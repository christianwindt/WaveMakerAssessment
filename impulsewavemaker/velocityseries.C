/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 1991-2010 OpenCFD Ltd.
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

Class
    Foam::velocity::sinevelocity
    virtual velocity class, different theories should be implemented in derivations
\*---------------------------------------------------------------------------*/
#include "velocityseries.H"
#include "interpolateXY.H"
namespace Foam
 {
  ////* * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //


void Foam::velocityseries::setTime(const scalar &Time)
{
        //Interpolate velocity at new time and apply
         NewVelocity_ = VelocityList_(Time);
}

vector Foam::velocityseries::velocity(const vector & p)
{
	return(NewVelocity_);
	}


scalar Foam::velocityseries::Xi(const vector &p)
{
	return(Depth_);
	}
	
scalar Foam::velocityseries::p(const vector &p)
{
	//only linear approximation for pressure
    //Useless?
	return(rho_*maggravity_*(Xi(p)-p.component(2)));
	}
	

//Validity checks and info  for all monochromatic wave types derived from velocity!!!
void Foam::velocityseries::checkUrsell()
{
	Info<<"####################  Wave data       ####################### "<<endl;
	Info<<"rho water  :	"<<rho_<<endl;
	Info<<"Type  	  :	velocity	"<<endl;
	Info<<"############################################################# "<<endl;
	}

//***************************Constructor********************************
Foam::velocityseries::velocityseries(IOdictionary waveDict, vector gravity, scalar waterdensity):wave(waveDict, gravity)
{
	
	vector dir  
	(
		waveDict.lookup("direction")
	);
	direction_ = dir/mag(dir);
	maggravity_= mag(gravity);
	gravityUnitV_ = gravity/maggravity_;//Normalise gravity vector 
	Depth_= readScalar(waveDict.lookup("waterLevel")); 
    VelocityList_ = interpolationTable<vector> 
    (
    waveDict.db().path()/"../constant"/"Wavemaker.dat"
    );
    
    VelocityList_.check();  
	}

}						




// End namespace Foam
 
// ************************************************************************* //
