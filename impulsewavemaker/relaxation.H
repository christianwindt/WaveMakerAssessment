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
    Foam::relaxation::sinerelaxation

Description
    Setting fields according to different relaxation theories. 
    * Relaxing fields to generate relaxations
    * Uses fields damp and relax for defining relaxation generation/dissipation areas

SourceFiles
    relaxation.C

\*---------------------------------------------------------------------------*/
#include "volFields.H"
#include "typeInfo.H"
#include "IOdictionary.H"
#include "autoPtr.H"
#include "mathematicalConstants.H"
#include "wave.H"
#include "labelIOList.H"
#include "cellSet.H"
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
namespace Foam
{

class relaxation
	{
	DynamicList<label> cellIDs_; 
	wave *pWave_;//Pointer to wave of type		
		
	void initrelaxationFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana,  volScalarField &relax);
	
	
	public:
	relaxation(wave * pWave, const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana,  volScalarField &relax);		
	void setrelaxCells(const volVectorField & CellCenters,volScalarField &relax);
	void relaxFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana,  volScalarField &relax);		
	void initFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana,  volScalarField &relax);		
		void setanaFields(   const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana,     volScalarField &relax);

	};
}
