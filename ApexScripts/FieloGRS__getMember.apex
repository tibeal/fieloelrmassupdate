public class AuthData {
    public String token;
    public String id;
    public String password;
}

System.debug('Calling Storefront API: getMemberAccount');

FieloGRS__Settings__c grsSettings = FieloGRS__Settings__c.getInstance(UserInfo.getProfileId());

AuthData auth = new AuthData();
auth.id = 'a0H4100000LJy23EAD';
auth.token = grsSettings.FieloGRS__ApiKey__c;

String domain = grsSettings.FieloGRS__Domain__c;
Integer timeout = 30000;

Blob auth_encoded = Blob.valueOf(JSON.serialize(auth));
Blob headerValue = Blob.valueOf(auth.id + ':' + EncodingUtil.base64Encode(auth_encoded));
String auth_header = 'Basic ' + EncodingUtil.base64Encode(headerValue);

System.debug(auth_header);

HttpRequest req = new HttpRequest();
req.setMethod('GET');
req.setHeader('Content-Type','application/x-www-form-urlencoded');
req.setHeader('Authorization', auth_header);
req.setEndpoint(domain + '/client/json.php/getMemberAccount');
req.setTimeout(timeout);

try {
	Http http = new Http();
	HTTPResponse res = http.send(req);
	System.debug(res.toString());
	System.debug(res.getBody());

	// Parse entire JSON response.
	if (res.getStatusCode() == 200 || res.getStatusCode() == 201 || res.getStatusCode() == 202) {

		Map<String,Object> member = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
		System.debug(member);
	}
} catch(System.CalloutException e) {
	System.debug('Failed: ' + e.getMessage());
}
