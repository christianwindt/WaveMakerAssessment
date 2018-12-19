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
    Foam::relaxation
    relaxation class
\*---------------------------------------------------------------------------*/
#include "relaxation.H"
 namespace Foam
 {
  ////* * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //

void Foam::relaxation::relaxFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana,   volScalarField &relax)
{
	setanaFields(CellCenters,U, Uana,  relax);
	U		=	relax*Uana		+	(scalar(1.)-relax)*U;

	};


void Foam::relaxation::initFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana,   volScalarField &relax)
{
	setanaFields(CellCenters,U, Uana,    relax);
	U		=	Uana;

	};

void Foam::relaxation::setanaFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana,    volScalarField &relax)
{
	pWave_->setTime(U.time().value());
	
		forAll(cellIDs_,i)
		{

				if (CellCenters[cellIDs_(i)].component(2) <= pWave_->Xi(CellCenters[cellIDs_(i)]))  
				{
					Uana[cellIDs_(i)] = pWave_->velocity(CellCenters[cellIDs_(i)]);		

				}
				else
				{
					Uana[cellIDs_(i)] = vector(0., 0., 0.);

				}
//			}
		}
	
	}

void Foam::relaxation::setrelaxCells(const volVectorField & CellCenters, volScalarField &relax)
{
     forAll(relax, i)
     {
         if (relax[i] > 0.00001)
         {
			cellIDs_.append(i);
         }
       }
	//Put in cellSet
     cellSet cells(CellCenters.mesh(), "relaxCells", cellIDs_.size());

	 forAll(cellIDs_, i)
	 {
		 cells.insert(cellIDs_[i]);
	 }

	 Info<<"Writing " << cellIDs_.size() << " cells to cellSet " << cells.name() << endl;
	 cells.write();
	}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //
relaxation::relaxation(wave * pWave,const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana,    volScalarField &relax)
{
	pWave_ = pWave;
	setrelaxCells(CellCenters, relax);
}

}
// End namespace Foam
 
// ************************************************************************* //
