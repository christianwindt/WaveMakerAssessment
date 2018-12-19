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
    Foam::wave::velocityseries

Description
    Apply velocity from given list over time

SourceFiles
    velocityseries.C

\*---------------------------------------------------------------------------*/
#include "volFields.H"
#include "typeInfo.H"
#include "IOdictionary.H"
#include "scalarListIOList.H"
#include "autoPtr.H"
#include "mathematicalConstants.H"
#include "wave.H"
#include "interpolationTable.H"
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
namespace Foam
{
#ifndef velocityseries_H
#define velocityseries_H
class velocityseries: public wave
	{
	protected:
	scalar evalwavenumber();
    vector NewVelocity_;
    interpolationTable<vector> VelocityList_;
	void checkUrsell();
	void setTime(const scalar & Time);
	inline scalar xstar(vector p){return(p&direction_);};//Get total distance in prop direction 
	
	//Eval coefficients 

	
	//Quick and dirty fix
	inline scalar coth(scalar x)
	{
	return(Foam::cosh(x)/Foam::sinh(x));
    }
	
	void setCoeffs();
	
	public:		
	vector velocity(const vector &c);
	scalar Xi(const vector & c);
	scalar p(const vector & c);

	        //- Select null constructed
    static autoPtr<velocityseries> New();
	
	velocityseries(IOdictionary waveDict, vector gravity, scalar waterdensity);
	~velocityseries(){};
	};
	
#endif
}
