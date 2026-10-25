import { LightningElement, wire, api } from 'lwc';
import getContact from '@salesforce/apex/ContactHandler.getContact';

export default class ContactDisplayComp extends LightningElement {
    @api recordId;
    contacts = [];
    error;

    @wire(getContact,{accountId : '$recordId'})
    wiredContact({data, error}){
        if(data){
            this.contacts = data;
            this.error = null;
        }else if(error){
            this.contacts = [];
            this.error = JSON.stringify(error);
        }
    }

    get hasContacts(){
        return this.contacts && this.contacts.length > 0;
    }
}