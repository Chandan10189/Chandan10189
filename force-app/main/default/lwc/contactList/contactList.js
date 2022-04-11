import { LightningElement,api,wire} from 'lwc';
import DisplayContact from '@salesforce/apex/ContactController.DisplayContact'

const colms = [
    { label: 'FirstName', fieldName: 'FirstName' },
    { label: 'LastName', fieldName: 'LastName'},
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'Email' },
   
];
export default class ContactList extends LightningElement {

    coulmns = colms;
    @api accountId;
    @wire(DisplayContact,{accountId : '$accountId'}) Contacts;
}