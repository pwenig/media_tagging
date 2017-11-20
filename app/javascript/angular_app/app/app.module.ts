import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { TimepickerModule } from 'ngx-bootstrap/timepicker';
import { TypeaheadModule, TabsModule } from 'ngx-bootstrap';

import { AppComponent } from './app.component';
import { CampaignComponent } from './campaign.component';
import { PackageComponent } from './package.component';
import { PlacementComponent } from './placement.component';
import { AdComponent } from './ad.component';
import { CreativeComponent } from './creative.component';
import {SelectComponent} from './select.component';
import {SelectStringComponent} from './selectString.component';
import {YearSelectComponent} from './yearselect.component';
import {MonthSelectComponent} from './monthselect.component';
import {DaySelectComponent} from './dayselect.component';
import {SearchComponent} from './search.component';
import {TreeComponent} from './tree.component';

import { MetadataService } from '../services/metadata_service';
import { CampaignInputService } from '../services/campaign_input_service';
import { PackageInputService } from '../services/package_input_service';
import { PlacementInputService } from '../services/placement_input_service';
import { AdInputService } from '../services/ad_input_service';
import { CreativeInputService } from '../services/creative_input_service';
import { AdTypeService } from '../services/ad_type_service';
import { CampaignTypeService } from '../services/campaign_type_service';
import { HistoryService } from '../services/history_service';
import {RangePipe} from '../shared/range.pipe'


@NgModule({
  declarations: [
    AppComponent,
    CampaignComponent,
    PackageComponent,
    PlacementComponent,
    AdComponent,
    CreativeComponent,
    SelectComponent,
    SelectStringComponent,
    YearSelectComponent,
    MonthSelectComponent,
    DaySelectComponent,
    SearchComponent,
    TreeComponent,
    RangePipe
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    FormsModule,
    TabsModule.forRoot(),
    TypeaheadModule.forRoot(),
    TimepickerModule.forRoot()
  ],
  providers: [MetadataService, CampaignInputService, 
              PackageInputService, PlacementInputService, 
              AdInputService, CreativeInputService, 
              AdTypeService, CampaignTypeService,
              HistoryService],
  bootstrap: [AppComponent]
})
export class AppModule { }
