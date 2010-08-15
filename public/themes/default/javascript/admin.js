function remove_fields(link) {
	$(link).previous('input[type=hidden]').value = '1';
	$(link).up('.upload').hide();
}

function add_fields(link, association, content) {
	var newId = new Date().getTime();
	var regExp = new RegExp('new_' + association, 'g');
	$(link).insert({
		before: content.replace(regExp, newId)
	});
	return false;
}

Event.observe(window, 'dom:loaded', function() {
	
});