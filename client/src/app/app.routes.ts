import { Routes } from '@angular/router'

// Components
import { HomeComponent } from './components/home/home.component';
import { ReportComponent } from './components/report/report.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';

export const AppRoutes: Routes = [
    {
        path: '',
        redirectTo: 'home',
        pathMatch: 'full'
    },
    {
        path: 'home',
        component: HomeComponent
    },
    {
        path: 'report',
        component: ReportComponent
    },
    {
    	path: '**',
    	component: PageNotFoundComponent
    }
];