var ML = function() {}
ML = {
	// variables
	
	// functions
	initialize: function() {
		
	}
}

var MessageCenter = function() {};
MessageCenter = {
	defaults: {
		matchString: /!!\$[0-9]{1,3}/gi,
		displayTarget: '.message_center'
	},
	
	showMessage: function(container, message, replacements) {
		var that = this;
		
		message = that.message(message, replacements);
		$(container).text(message);
		
		// var replaceAreas = message.match(that.defaults.matchString);
		// if (replaceAreas) {
		// 	for(i = 0; i < replaceAreas.length; i += 1) {
		// 		message = message.replace(replaceAreas[i], replacements[i]);
		// 	}
		// }
	},
	
	revealMessage: function(container, message) {
		var that = this;
	},
	
	message: function(message, replacements) {
		var that = this;
		var replaceAreas = message.match(that.defaults.matchString);
		if (replaceAreas) {
			for(i = 0; i < replaceAreas.length; i += 1) {
				message = message.replace(replaceAreas[i], replacements[i]);
			}
		}
		return message;
	}
}

$.extend({}, ML, MessageCenter);