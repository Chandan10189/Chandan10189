import { LightningElement } from 'lwc';
import {SHowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import NAME_FIELD from '@salesforce/schema/Account.Name'
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue'
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry'
import TYPE_FIELD from '@salesforce/schema/Account.Type'
import ACCOUNT_NUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';





export default class RecordFormDemo extends LightningElement {
    objectName = ACCOUNT_OBJECT
    fieldList = [NAME_FIELD,ANNUAL_REVENUE_FIELD,TYPE_FIELD,INDUSTRY_FIELD,ACCOUNT_NUMBER_FIELD]

    successHandler(event){
        console.log(event.detail.id)
        const toastEvent = new SHowToastEvent({
            title : "Account created",
            message: "Record ID:"+event.detail.id,
            variant : "Success"
        });
        this.dispatchEvent(toastEvent)

    }
}