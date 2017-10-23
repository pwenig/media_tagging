import { Component, OnInit, Input, EventEmitter, Output } from '@angular/core';
import { CampaignInputService } from '../services/campaign_input_service';

@Component({
  selector: 'campaign',
  template: `
    <h2 class="campaign-title">Campaign Input</h2>
    <p *ngIf="showFinal">{{campaignInput.campaignInputTag }}</p>
    <div class="input-tag-container">
      <div class="row">
        <search [inputTags]="campaignTags" [searchDesc]="searchDesc" *ngIf="showSearch" (newTag)="showSelectors=true && showButtons=true" (tagChosen)="tagSelected($event)"></search>
        <section class="input-tag" *ngIf="showButtons">
          <input [ngModel]="campaignInput.campaignInputTag"class="form-control" [disabled]=true>
          <button class="new-tag" *ngIf="!existingCampaignInput" type="submit" (click)="saveInput()">Create</button>
          <button class="new-tag" *ngIf="existingCampaignInput"  type="submit" (click)="selectInput()">Select</button>
        </section>
      </div>
    </div>

    <div *ngIf="showSelectors">
      <div class="select-container">
        <div class="row">
        
          <section class="select">
            <div class="network-column" *ngIf="networks && networks.length > 0">
              <select-component [label]="networkLabel" [options]="networks" (selected)="attributeUpdated($event, 'network')"></select-component>
            </div>
            <div class="column" *ngIf="campaignInput.network">
               <select-component [label]="programLabel" [options]="campaignInput.network.programs" (selected)="attributeUpdated($event, 'program')"></select-component>
            </div>
            <div class="column" *ngIf="campaignInput.network">
              <select-component [label]="seasonLabel" [options]="seasons" (selected)="attributeUpdated($event, 'season')"></select-component>
            </div>
          </section>

          <section class="select" *ngIf="campaignInput.season">
            <div class="campaign-type-column"> 
              <select-component [label]="campaignTypeLabel" [options]="campaignTypes" (selected)="attributeUpdated($event, 'campaignType')"></select-component>
            </div>
            <div class="custom-column"> 
              <label for="type">Campaign Custom</label><br>
              <input type="text" id="custom" [(ngModel)]="campaignInput.custom" placeholder="Enter Custom" (change)="checkAttributes()">
            </div>
          </section>

          <section class="select" *ngIf="campaignInput.custom">
            <div class="year-column">
               <year-select-component [label]="startYearLabel" (selected)="attributeUpdated($event, 'startYear')"></year-select-component>
            </div>
            <div class="column">
              <month-select-component [label]="startMonthLabel" (selected)="attributeUpdated($event, 'startMonth')"></month-select-component>
            </div>
            <div class="column">
             <day-select-component [label]="startDayLabel" (selected)="attributeUpdated($event, 'startDay')"></day-select-component>
            </div>
          </section>

          <section class="select" *ngIf="campaignInput.startDay">
            <div class="year-column">
              <year-select-component [label]="endYearLabel" (selected)="attributeUpdated($event, 'endYear')"></year-select-component>
            </div>
            <div class="column">
              <month-select-component [label]="endMonthLabel" (selected)="attributeUpdated($event, 'endMonth')"></month-select-component>
            </div>
            <div class="column">
              <day-select-component [label]="endDayLabel" (selected)="attributeUpdated($event, 'endDay')"></day-select-component>
            </div>
          </section>

        </div>

      </div>

    </div>
  `
})

export class CampaignComponent implements OnInit {

  @Input() networks: any[];
  @Input() seasons: any[];
  @Input() campaignTypes: any[];
  @Input() campaignTags: any[];
  @Output() campaignInputTagFinal = new EventEmitter();

  campaignInput: any = {};
  campaignInputTag: any;
  networkLabel: string = 'Network';
  programLabel: string = 'Program';
  seasonLabel: string = 'Season';
  campaignTypeLabel: string = 'Campaign Type';
  startYearLabel: string = 'Start Year';
  startMonthLabel: string = 'Start Month';
  startDayLabel: string = 'Start Day';
  endYearLabel: string = 'End Year';
  endMonthLabel: string = 'End Month';
  endDayLabel: string = 'End Day';
  showFinal: boolean = false;
  showSelectors: boolean = false;
  showButtons: boolean = false;
  showSearch: boolean = true;
  existingCampaignInput: any;
  searchDesc: string = 'Search Campaign Tags';
  
  constructor( private _campaign: CampaignInputService) {}

  ngOnInit() {
    this.campaignInput.startYear = 2017;
    this.campaignInput.endYear = 2017;
  };

  // Updates the attribute when it is selected from child components
  attributeUpdated(value, attribute) {
    this.campaignInput[attribute] = value;
    this.checkAttributes();
  }

  // Checks to see if everything is selected before creating the tag
  checkAttributes() {
    if(this.campaignInput.network && 
      this.campaignInput.program &&
      this.campaignInput.season &&
      this.campaignInput.campaignType && 
      this.campaignInput.custom &&
      this.campaignInput.startYear &&
      this.campaignInput.startMonth &&
      this.campaignInput.startDay &&
      this.campaignInput.endYear &&
      this.campaignInput.endMonth &&
      this.campaignInput.endDay
      ) { this.createTag(); };
  }

  createTag() {
    // Create the campaign input tag
    this.campaignInput.campaignInputTag = 
      this.campaignInput.network.abbrev + '_' + 
      this.campaignInput.program.abbrev + '_' +
      this.campaignInput.season.abbrev + '_' +
      this.campaignInput.campaignType.abbrev + '_' +
      this.campaignInput.custom + '_' +
      this.campaignInput.startYear +
      this.campaignInput.startMonth +
      this.campaignInput.startDay + '-' +
      this.campaignInput.endYear +
      this.campaignInput.endMonth +
      this.campaignInput.endDay
    // Check to see if the tag already exists
    if(this.campaignInput.campaignInputTag) {
      this.verifyTag();
    }
    
  }

  verifyTag() {
    this._campaign.verifyInput(this.campaignInput.campaignInputTag).subscribe(
      
      (result) => {
        // Show either select or create button
        this.existingCampaignInput = result;
        this.campaignInputTagFinal.emit(result);

      },
      (error) => {
        console.log('Error', error)
      }
    )

  }
  saveInput() {
    // Create the params
    var createParams = {
      network_id: this.campaignInput.network.id,
      program_id: this.campaignInput.program.id,
      season_id: this.campaignInput.season.id,
      campaign_type_id: this.campaignInput.campaignType.id,
      custom: this.campaignInput.custom,
      start_year: this.campaignInput.startYear,
      start_month: this.campaignInput.startMonth,
      start_day: this.campaignInput.startDay,
      end_year: this.campaignInput.endYear,
      end_month: this.campaignInput.endMonth,
      end_day: this.campaignInput.endDay,
      campaign_input_tag: this.campaignInput.campaignInputTag
    }
    this._campaign.createInput(createParams).subscribe(

      (result) => {
        this.showSelectors = false;
        this.showButtons = false;
        this.showFinal = true;
        this.campaignInputTagFinal.emit(result);
      },
      (error) => {
        console.log('ERROR', error)
      }
    );

  }

  selectInput() {
    this.showFinal = true;
    this.showSelectors = false;
    this.showButtons = false;
    this.campaignInputTagFinal.emit(this.existingCampaignInput);
  }

  tagSelected(tag) {
    this.campaignInput.campaignInputTag = tag;
    this.showFinal = true;
    this.showSearch = false;
    this.existingCampaignInput = true
    this.campaignInputTagFinal.emit(this.existingCampaignInput);
    this.verifyTag();
  }

}