import { LightningElement,wire,track} from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts'

export default class AccountList extends LightningElement {

    @wire(getAccounts) Acco;
     @track accountIdFromParents;

    handleOnClick(event){
         event.preventDefault();
        this.accountIdFromParents = event.target.dataset.accountid;
        //'0015g00000bklisAAA';
        //event.target.dataset.accountid;
        //  console.log(this.accountIdFromParents);

    }
}