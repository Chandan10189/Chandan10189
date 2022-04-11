({
	handleKeyUp : function(component, event, helper) {
		var searchText = component.find('enter-search').get('v.value');
        alert(searchText);
        var searchEvent = component.getEvent('LookupEvent');
	}
})