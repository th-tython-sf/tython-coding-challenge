({
    handleVoid : function(component, event, helper) {
        // Call to Apex Controller Method: voidPayment
        var voidPayment = component.get("c.voidPayment");
        voidPayment.setParams({
            accountId: component.get('v.accountPayment').accountId
        });
        voidPayment.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnValue = response.getReturnValue();

                var AccountPaymentVoidCompleteEvt = component.getEvent('AccountPaymentVoidCompleteEvt');
                AccountPaymentVoidCompleteEvt.fire();
            }
            else {

            }
        });
        $A.enqueueAction(voidPayment);
    }
})
