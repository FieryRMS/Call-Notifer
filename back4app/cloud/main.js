import Parse from "parse";

Parse.Cloud.beforeSave(Parse.User, async (request) => {
	if (request.object.isNew()) request.object.set("ownsRole", undefined);
	else if (!request.master) {
		if (request.object.dirty("username")) throw "Cannot change username";
		if (request.object.dirty("ownsRole")) throw "Cannot change ownsRole";
	}
});

Parse.Cloud.afterSave(Parse.User, async (request) => {
	if (request.object.existed()) return;

	const role = await new Parse.Role(request.object.getUsername(), new Parse.ACL(request.object))
		.save({}, { useMasterKey: true });

	request.object.set("ownsRole", role);
	await request.object.save({}, { useMasterKey: true });
});

Parse.Cloud.define("generateOTP", async (request) => {
	if (request.user == null) throw "Not logged in";

	let role = request.user.get("ownsRole");
	await new Parse.Query("OTP").equalTo("addTo", role).each(async (otp) => {
		await otp.destroy({ useMasterKey: true });
	});

	let OTP = await new Parse.Object("OTP").save({
		addTo: role,
		expires: new Date(Date.now() + 1000 * 60 * 5)
	}, { useMasterKey: true });

	return OTP.id;
});

Parse.Cloud.define("verifyOTP", async (request) => {
	let code = request.params.code;
	if (request.user == null) throw "Not logged in";
	if(code == null) throw "No code provided";

	let OTP = await new Parse.Query("OTP")
					.equalTo("objectId", code)
					.include("addTo")
					.first({ useMasterKey: true });
	if (OTP == null) throw "No OTP found";

	if (OTP.get("expires") < new Date()) {
		await OTP.destroy({ useMasterKey: true });
		throw "OTP expired";
	}
	
	let role = request.user.get("ownsRole");
	if (OTP.get("addTo").get("objectId") == role) throw "Cannot subscribe to self";

	await OTP.get("addTo").getUsers().add(request.user);
	await OTP.get("addTo").save({}, { useMasterKey: true });
	return "Successfully subscribed to " + OTP.get("addTo").get("name")+"!";
});