function remove_fields(link) {
	$(link).previous('input[type=hidden]').value = '1';
	$(link).up('.upload').hide();
}

function add_fields(link, association, content) {
	var newId = new Date().getTime();
	var regExp = new RegExp('new_' + association, 'g');
	$(link).before(content.replace(regExp, newId));
	ML_Admin.bindUploadFields();
	return false;
}

var ML_Admin = function() {}
ML_Admin = {
	// variables
	selectors: {
		post: {
		
		}
	},
	defaults: {
		fileSizes: ['thumb', 'small', 'original', 'large']
	},
	messages: {
		fileUpload: '{{image /images/uploads/!!$0_!!$1.!!$2}} (click to cycle through sizes)'
	},

	// methods
	initialize: function() {
		var that = this;
		that.bindUploadFields();
	},

	// POST
	// image upload fields
	bindUploadFields: function() {
		var that = this;
		var uploadFields = $('input:file');
		
		uploadFields.each(function() {
			$(this).change(function() {
				var fileParts = $(this).val().split('.');
				var baseFilename = fileParts[0];
				var extension = fileParts[1];
				for(i = 0; i < that.defaults.fileSizes.length; i += 1) {
					MessageCenter.showMessage($(this).parent().find('.upload-file-names'), that.messages.fileUpload, [baseFilename, that.defaults.fileSizes[0], extension]);
					that.bindImageSizeSelection($(this).parent().find('.upload-file-names'), baseFilename, extension)
				}
			});
		});
	},
	
	bindImageSizeSelection: function(container, baseFilename, extension) {
		var that = this;
		var sizeIndex = 1;
		
		$(container).click(function() {
			MessageCenter.showMessage($(container), that.messages.fileUpload, [baseFilename, that.defaults.fileSizes[sizeIndex], extension]);
			if (sizeIndex === that.defaults.fileSizes.length - 1) {
				sizeIndex = 0;
			} else {
				sizeIndex += 1;
			}
		});
	}
}

$.extend({}, ML, ML_Admin);

$(document).ready(function() {
	var admin = ML_Admin.initialize();
});