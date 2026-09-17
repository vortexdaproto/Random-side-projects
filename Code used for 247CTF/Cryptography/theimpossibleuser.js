function toHex(str) {
	let hex = "";
	for(i=0;i<str.length;i++) {
		hex = hex + str.charCodeAt(i).toString(16);
    }
	console.debug(str.length + ": " + hex)
	return hex
}
console.debug("impossible_flag".length)
console.debug("_user".length)
toHex("impossible_flag")
toHex("_user")
/* Take both strings, encrypt them and take the first 32 chars of this.*/
toHex("impossible_flagXuser") // Get the start of the encrypted string
/* And the last 32 characters of this string when encrypted*/
toHex("impossible_flaX_user") // Get the end of the encrypted string
/* And you will get the flag.*/
