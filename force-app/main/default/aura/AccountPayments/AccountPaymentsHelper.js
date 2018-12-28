({
    getAccounts : function(component, event, helper) {
        // Call to Apex Controller Method: getAccounts
        var getAccounts = component.get("c.getAccounts");
        getAccounts.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnValue = response.getReturnValue();

                var accounts = JSON.parse(returnValue);

                component.set('v.accounts', accounts);
            }
            else if (state === 'INCOMPLETE') {
            }
            else if (state === 'ERROR') {
            }
        });
        $A.enqueueAction(getAccounts);
    }

})
