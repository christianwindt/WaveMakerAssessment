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
    Foam::wave

Description
	virtual base class for all wave/spectral types

SourceFiles
    wave.C

\*---------------------------------------------------------------------------*/
#include "volFields.H"
#include "typeInfo.H"
#include "IOdictionary.H"
#include "autoPtr.H"
#include "mathematicalConstants.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
namespace Foam
{
#ifndef WAVE_H
#define WAVE_H
class wave
	{
	//Variables ALL seastates need
	protected:
	scalar maggravity_;
	vector gravityUnitV_;
	scalar Time_;
	scalar Depth_;
	scalar rho_;
	vector direction_;

	void checkDir()
	{
	//Implement check on orhtogonality of dir and gravity
	}	

	public:		
	virtual vector velocity(const vector &c){return(vector(0,0,0));};
	virtual scalar Xi(const vector &c){return(0.);};
	virtual scalar p(const vector & c){return(0.);};
	virtual void setTime(const scalar &Time){};
	
	//Constructor reading and checking basic data 
	wave(IOdictionary waveDict, vector gravity){
	Depth_= readScalar(waveDict.lookup("waterLevel")); 
	vector dir  
	(
		waveDict.lookup("direction")
	);
	direction_ = dir/mag(dir);
	maggravity_= mag(gravity);
	gravityUnitV_ = gravity/maggravity_;//Normalise gravity vector 
	
	};
	wave(scalar rho)
	{
		rho_ = rho;
	};

	virtual ~wave(){};
	};
#endif

}
