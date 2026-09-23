import { LightningElement, api, track } from 'lwc';
import createOrderWithItems from '@salesforce/apex/OrderManagementController.createOrderWithItems';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class OrderCreator extends LightningElement {
    @api recordId; // Account Id
    @track products = [];
    
    handleAddProduct() {
        this.products.push({ pbeId: '', qty: 1, price: 0 });
    }
    
    async handleCreateOrder() {
        try {
            const orderId = await createOrderWithItems({ 
                accountId: this.recordId, 
                products: this.products 
            });
            
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success',
                message: 'Order Created: ' + orderId,
                variant: 'success'
            }));
            
        } catch(error) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: error.body.message,
                variant: 'error'
            }));
        }
    }
}
