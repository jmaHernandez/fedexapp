import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';
import { RouterModule } from '@angular/router'

// Components
import { AppComponent } from './app.component';
import { HomeComponent } from './components/home/home.component';
import { ReportComponent } from './components/report/report.component';

// Routes
import { AppRoutes } from './app.routes';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    ReportComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
    RouterModule.forRoot(AppRoutes) 
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
