// import Parse from "parse";

Parse.Cloud.beforeSave(Parse.User, async (request) => {
	if (request.object.isNew()) request.object.set("ownsRole", undefined);
	else if (!request.master) {
		if (request.object.dirty("username")) throw "Cannot change username";
		if (request.object.dirty("ownsRole")) throw "Cannot change ownsRole";
	}
});

Parse.Cloud.beforeSave("CallLogs", async (request) => {
	if (request.object.isNew()) {
		if (request.user == null) throw "Not logged in";
		let ACL = new Parse.ACL(request.user);
		ACL.setRoleReadAccess(request.user.get("ownsRole"), true);
		request.object.setACL(ACL);
		request.object.set("owner", request.user.getUsername());
	}
	else if (!request.master) {
		let denyCols = ["ACL", "callerName", "callType", "phoneNumber", "owner"];
		for (let col of denyCols) {
			if (request.object.dirty(col)) throw "Cannot change " + col;
		}
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
	}, { useMasterKey: true });

	let OTP = await new Parse.Object("OTP").save({
		addTo: role,
		expires: new Date(Date.now() + 1000 * 60 * 5)
	}, { useMasterKey: true });

	return OTP.id;
});

Parse.Cloud.define("verifyOTP", async (request) => {
	let code = request.params.otp;
	if (request.user == null) throw "Not logged in";
	if (code == null) throw "No OTP provided";

	let OTP = await new Parse.Query("OTP")
		.equalTo("objectId", code)
		.include("addTo")
		.first({ useMasterKey: true });
	if (OTP == null) throw "Invalid OTP!";

	if (OTP.get("expires") < new Date()) {
		await OTP.destroy({ useMasterKey: true });
		throw "OTP expired";
	}

	let role = request.user.get("ownsRole");
	if (OTP.get("addTo").id == role.id) throw "Cannot subscribe to self, please create another account";

	await OTP.get("addTo").getUsers().add(request.user);
	await OTP.get("addTo").save({}, { useMasterKey: true });
	await OTP.destroy({ useMasterKey: true });
	return "Successfully subscribed to " + OTP.get("addTo").get("name") + "!";
});

Parse.Cloud.define("getSubscribedUsers", async (request) => {
	if (request.user == null) throw "Not logged in";

	let role = await new Parse.Query(Parse.Role)
		.equalTo("objectId", request.user.get("ownsRole").id)
		.first({ useMasterKey: true });
	if (role == null) throw "user does not own a role";

	let usernames = [];
	await role.getUsers().query().each((user) => {
		usernames.push(user.getUsername());
	}, { useMasterKey: true });
	usernames.sort();
	return usernames;
});

Parse.Cloud.define("unsubscribeUser", async (request) => {
	let username = request.params.username;
	if (request.user == null) throw "Not logged in";
	if (username == null) throw "No user provided";

	let user = await new Parse.Query(Parse.User)
		.equalTo("username", username)
		.first({ useMasterKey: true });

	// if user does not exist, return success so as to not reveal existence of user
	if (user == null) return "Successfully unsubscribed " + username + "!";

	let role = await new Parse.Query(Parse.Role)
		.equalTo("objectId", request.user.get("ownsRole").id)
		.first({ useMasterKey: true });
	if (role == null) throw "user does not own a role";

	role.getUsers().remove(user);
	await role.save({}, { useMasterKey: true });
	return "Successfully unsubscribed " + username + "!";
});