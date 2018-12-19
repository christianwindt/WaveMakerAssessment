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
    virtual wave class, different theories should be implemented in derivations
\*---------------------------------------------------------------------------*/
//#include "wave.H"
 //namespace Foam
 //{
  //////* * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //

////Chooses analytical solution function based on type
//void Foam::wave::setanaFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana, volScalarField &alpha1, volScalarField &alpha1ana,volScalarField &p, volScalarField &pana,  volScalarField &relax)
//{
	//if (Type_ == word("sinewave")  )
	//{
		//setsineFields(CellCenters,U, Uana, alpha1, alpha1ana,p,pana, relax);
	//}
	//else if (Type_ == word("stokes2wave")  )
	//{
		//setstokesFields(CellCenters,U, Uana, alpha1, alpha1ana,p,pana, relax);
	//}
	//else if (Type_ == word("cnoidalwave")  )
	//{
		//setcnoidalFields(CellCenters,U, Uana, alpha1, alpha1ana,p,pana, relax);
	//}
	//else
	//{
		//FatalErrorIn("Foam::wave::setanaFields")
		//<< "WARNING: Wave type not (yet) implemented! " << Type_
		//<< abort(FatalError);
	//}
	//}


//void Foam::wave::readDict(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana, volScalarField &alpha1, volScalarField &alpha1ana,volScalarField &p, volScalarField &pana, volScalarField &relax)
//{
	//IOdictionary waveDict
	//(
	//IOobject
	//(
	//"waveDict",
	//U.time().constant(),//registry?
	//U.db(),
	//IOobject::MUST_READ,
	//IOobject::NO_WRITE
	//)
	//);
	
	//word Type   //Very ugly workaround, correct later
	//(
	//waveDict.lookup("Type")
	//);
	//Type_ = Type;
	
	//Info<<"#####################################################"<<endl;
	//Info<<"Selecting wave type: "<< Type_<<endl;
	//vector dir   //Ugly workaround, correct later
	//(
	//waveDict.lookup("direction")
	//);
	//direction_ = dir/mag(dir);

	//if (Type_ == word("sinewave"))
	//{
		//readstokesDict(waveDict);
		//setsineFields(CellCenters,U, Uana, alpha1, alpha1ana,p,pana, relax);
	//}
	//else if (Type_ == word("stokes2wave"))
	//{
		//readstokesDict(waveDict);
		//setstokesFields(CellCenters,U, Uana, alpha1, alpha1ana,p,pana, relax);
	//}
	//else if (Type_ == word("cnoidalwave"))
	//{
		//readcnoidalDict(waveDict);
		//setcnoidalFields(CellCenters,U, Uana, alpha1, alpha1ana,p,pana, relax);
	//}
	//else
	//Info<<"Wave type not implemented yet!";

	//word init
	//(
	//waveDict.lookup("init")
	//);
	//init_ = init;
	
	//if(init_ == "true")
	//{
		//initwaveFields( CellCenters, U, Uana, alpha1, alpha1ana,p, pana, relax);
		//}

//}

//void Foam::wave::readstokesDict(IOdictionary &waveDict)
//{
//WaveHeight_= readScalar(waveDict.lookup("WaveHeight")); 
//Period_= readScalar(waveDict.lookup("Period")); 
//waterLevel_= readScalar(waveDict.lookup("waterLevel")); 

//omega_	=  mathematicalConstant::twoPi/Period_;	
//wavenumber_ = evalwavenumber();
//Lambda_ = mathematicalConstant::twoPi/wavenumber_;
//celerity_  = (Foam::sqrt( mag(gravity_)/wavenumber_*Foam::tanh(wavenumber_*waterLevel_) ));
//checkUrsell();
//}

//void Foam::wave::readcnoidalDict(IOdictionary &waveDict)
//{
//WaveHeight_= readScalar(waveDict.lookup("WaveHeight")); 
//Period_= readScalar(waveDict.lookup("Period")); 
//waterLevel_= readScalar(waveDict.lookup("waterLevel")); 

////Set all variables that are needed in time loop
//scalar Konstant;
//scalar m0,ka,eH,ks,la,mu,eHSqu;
//scalar cel;
//scalar E;

//Konstant = 3*mag(gravity_)*WaveHeight_*Foam::pow(Period_,2)/(16*pow(waterLevel_,2));


//scalar left = 0.5;
//scalar right = 1-fabs(1000*SMALL);
//scalar rl,rr,rm, middle;
//int i=0;
//while ( (fabs(left-right) > 1000000000*SMALL) ) 
//{
	//i=i+1;
	//rl = iterm(Konstant, left);
	//rr = iterm(Konstant, right);
	//if (rl*rr > 0)
	//{
		//FatalErrorIn("Foam::wave::readcnoidalDict")
		//<< "Iterative Solution of first order dispersion relation failed! " << Konstant
		//<< abort(FatalError);
	//}
	//middle = (left+right)/2;
	//rm = iterm(Konstant, middle);
	//if (rm*rl<0)
		//right = middle;
	//else
		//left = middle;
//}	
//m0 = middle;
//Info<<"m first order is "<<middle<<" found after "<<i <<" Iterations."<<endl;
//ka = sqrt(m0);
//eH = WaveHeight_/2./(2.*waterLevel_);
//ks = sqrt(1.-pow(ka,2.));
//la = pow(ks,2)/pow(ka,2.);

//i = 0;
//left = 0.5;
//right = 1-fabs(1000*SMALL);
//Konstant = ( 3.*mag(gravity_)*WaveHeight_*pow(Period_,2)/( 16.*pow(waterLevel_,2) ) * ( 1.-eH*(1.+2.*la)/4. ) );
//while ( (fabs(left-right) > 1000000000*SMALL) ) 
//{
	//i=i+1;
	//Konstant = ( 3*mag(gravity_)*WaveHeight_*pow(Period_,2)/( 16*pow(waterLevel_,2) ) * ( 1-eH*(1+2*((1-left)/left))/4 ) );
	//rl = iterm(Konstant, left);
	//Konstant = ( 3*mag(gravity_)*WaveHeight_*pow(Period_,2)/( 16*pow(waterLevel_,2) ) * ( 1-eH*(1+2*((1-right)/right))/4 ) );
	//rr = iterm(Konstant, right);
	//if (rl*rr > 0)
	//{
		//FatalErrorIn("Foam::wave::readcnoidalDict")
		//<< "Iterative Solution of second order dispersion relation failed! " << Konstant
		//<< abort(FatalError);
	//}
	//middle = (left+right)/2;
	//rm = iterm(Konstant, middle);
	//if (rm*rl<0)
		//right = middle;
	//else
		//left = middle;
//}
//Info<<"m second order is "<<middle<<" found after "<<i <<" Iterations."<<endl;
//m_ = middle;
//K_ = alglib::ellipticintegralk(m_);
//E = alglib::ellipticintegrale(m_);

//ka = sqrt(m_);
//eH = WaveHeight_/2./(2.*waterLevel_);
//eHSqu = pow(eH,2);
//ks = sqrt(1.-pow(ka,2));
//la = pow(ks,2)/pow(ka,2);
//mu = E/(pow(ka,2)*K_);
//schwall_ = sqrt(mag(gravity_*waterLevel_));
//cel = schwall_ * (1.+ eH * 0.5*(1. + 2.*la - 3*mu)) + eHSqu/40.*(-6.-16.*la+5.*mu-16.*pow(la,2)+10.*mu*la+15.*pow(mu,2));
//Lambda_ = cel*Period_;

//B00_ = eH*(la-mu)+Foam::pow(eH,2)/4*(la-mu-2.*Foam::pow(la,2)+2*Foam::pow(mu,2));
//B10_ = eH + Foam::pow(eH,2)/4*(1-6.*la+2.*mu);
//B20_ = -eHSqu;
//B01_ = 3./2.*la*eHSqu;
//B11_ = 3*eHSqu*(1-la);
//B21_ = -9./2.*eHSqu;
//A0_ = eH*(la-mu)+eHSqu/4*(-2*la+mu-2*pow(la,2)+2*la*mu);
//A1_ = eH-3./4.*eHSqu;
//A2_ = 3./4.*eHSqu;

//scalar P0 = 3.0/2.0;
//scalar P1 = 0.5*(1.+2.0*la-3.0*mu);
//scalar P2 = 1.0/40.0*(-1.0-16.*la+15.*mu-16.*Foam::pow(la,2)+30.*la*mu);
//pb_ = rhowater_*mag(gravity_)*waterLevel_*(P0+eH*P1+eHSqu*P2);
//Info <<"pb_	" << pb_ <<endl;
//Info <<"P0	" << P0 <<endl;
//Info <<"P1	" << P1 <<endl;
//Info <<"P2	" << P2 <<endl;
//Info <<"la	" << la <<endl;
//Info <<"mu	" << mu <<endl;
//checkUrsell();
//}

//void Foam::wave::relaxwaveFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana, volScalarField &alpha1, volScalarField &alpha1ana,volScalarField &p, volScalarField &pana,  volScalarField &relax)
//{
	//setanaFields(CellCenters,U, Uana,alpha1, alpha1ana,p, pana,  relax);
	//U		=	relax*Uana		+	(scalar(1)-relax)*U;
	//alpha1	=	relax*alpha1ana	+	(scalar(1)-relax)*alpha1;
	//p		= 	relax*pana		+ 	(scalar(1)-relax)*p;
	//};


//void Foam::wave::initwaveFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana, volScalarField &alpha1, volScalarField &alpha1ana,volScalarField &p, volScalarField &pana, volScalarField &relax)
//{
	//setanaFields(CellCenters,U, Uana,alpha1, alpha1ana, p, pana,  relax);
	//U		=	Uana;
	//alpha1	=	alpha1ana;
	//p		=	pana;
	//};

//void Foam::wave::setsineFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana, volScalarField &alpha1, volScalarField &alpha1ana,volScalarField &p, volScalarField &pana, volScalarField &relax)
//{
	//scalar omegaTime = omega_*U.time().value();
	//scalar Depthexpress = 0;
	//scalar DistTime = 0;
		//forAll(CellCenters,i)
		//{
			//DistTime = -omegaTime+wavenumber_*(CellCenters[i].component(0)*direction_[0]+CellCenters[i].component(1)*direction_[1]);
			//if ( CellCenters[i].component(2) <= waterLevel_+WaveHeight_/2*Foam::sin(DistTime) )
			//{
				//Depthexpress = WaveHeight_/2*omega_*Foam::exp( wavenumber_*(CellCenters[i].component(2)-waterLevel_ )  );
				////Info<< "Depthexpress : " <<Depthexpress<< endl;
				
				//Uana[i] = (
						//gravityUnitV_*Depthexpress*Foam::cos(DistTime) +
						 //direction_*Depthexpress*Foam::sin(DistTime) 
						//);
						
				//pana[i] = rhowater_*mag(gravity_)*(CellCenters[i].component(2)-waterLevel_ )+rhowater_*mag(gravity_)*WaveHeight_/2.*cosh(wavenumber_*(waterLevel_+CellCenters[i].component(2)))/cosh(wavenumber_*waterLevel_)*Foam::cos(DistTime);
				
						
				//alpha1ana[i]=1;
			//}
			//else
			//{
				//Uana[i] = U[i]*alpha1[i];
				//alpha1ana[i] = alpha1[i];
				//pana[i] = 0.;
			//}
		//}
	
	//}
//void Foam::wave::setstokesFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana, volScalarField &alpha1, volScalarField &alpha1ana,volScalarField &p, volScalarField &pana, volScalarField &relax)
//{
	//scalar omegaTime = omega_*U.time().value();
	//scalar xi,DistTime,u,w = 0.;
		//forAll(CellCenters,i)
		//{
			//DistTime = omegaTime-wavenumber_*(CellCenters[i].component(0)*direction_[0]+CellCenters[i].component(1)*direction_[1]);
			//scalar kh = wavenumber_*waterLevel_;
			//xi = waterLevel_ + Foam::cos(DistTime)*(WaveHeight_/2 + (Foam::pow(WaveHeight_,2)*wavenumber_*Foam::cos(kh))/(16*pow(sinh(kh),3)*(2+cosh(2*kh))));

			//if ( CellCenters[i].component(2) < xi  )
			//{
				//u = WaveHeight_/2.*mag(gravity_)/omega_*cosh(wavenumber_*(CellCenters[i].component(2)))/cosh(kh)*Foam::cos(DistTime)
							//+ 3./16.*Foam::pow(WaveHeight_,2)*omega_*wavenumber_*cosh(2.*kh*(CellCenters[i].component(2)))/Foam::pow(sinh(kh),4)*
							//Foam::cos(2*DistTime);
				//w = WaveHeight_/2*mag(gravity_)/omega_*sinh(wavenumber_*(CellCenters[i].component(2)))/cosh(kh)*Foam::sin(DistTime)
							//+ 3./16.*Foam::pow(WaveHeight_,2)*omega_*wavenumber_*sinh(2.*kh*(CellCenters[i].component(2)))/Foam::pow(sinh(kh),4)*
							//Foam::sin(2*DistTime);
				
				//Uana[i] = (
							//gravityUnitV_*w +
							//direction_*u
						//);
				//alpha1ana[i]=1;
				
				//pana[i] = max(0., rhowater_*mag(gravity_)*(xi - CellCenters[i].component(2)));
				
			//}		
			
			//else
			//{
				//Uana[i] = vector(0.,0.,0.);
				//alpha1ana[i] = 0.;
				//pana[i] = 0.;
			//}
		//}
	
	//}
	
	
//void Foam::wave::setcnoidalFields(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana, volScalarField &alpha1, volScalarField &alpha1ana, volScalarField &p, volScalarField &pana, volScalarField &relax)
//{
//scalar sn,cn,dn,ph,csd,cn2,cn4,theta, xi;
	
//forAll(CellCenters,i)
//{
//theta = 2*K_*( U.time().value()/Period_ - direction_[0]*CellCenters[i].component(0)/Lambda_ - direction_[1]*CellCenters[i].component(1)/Lambda_ );
////Info<<"theta: "<<theta<<endl;
//alglib::jacobianellipticfunctions(theta , m_, sn, cn, dn, ph );

//csd = sn*cn*dn; // == ph?
//cn2 = pow(cn,2);
//cn4 = pow(cn,4);

//xi = waterLevel_+ waterLevel_*(A0_+A1_*cn2+A2_*cn4);
		
	//if ( CellCenters[i].component(2) <= xi )
	//{
	    	//Uana[i] = direction_*schwall_ * ( (B00_+B10_*cn2+B20_*cn4) - 0.5*pow((CellCenters[i].component(2)+waterLevel_)/waterLevel_,2) * (B01_+B11_*cn2+B21_*cn4) )
						//-gravityUnitV_*schwall_*4*K_*waterLevel_*csd/Lambda_ * ((CellCenters[i].component(2)+waterLevel_)/waterLevel_ * (B10_+2*B20_*cn2) - 1/6*pow((CellCenters[i].component(2)+waterLevel_)/waterLevel_,3) * (B11_+2*B21_*cn2) );
			
			
			////pana[i] 	= pb_-
				////			rhowater_/2*(Foam::pow(( sqrt( Foam::pow(Uana[i].component(0),2)+Foam::pow(Uana[i].component(1),2) ) -celerity_),2)+Foam::pow(Uana[i].component(2),2))-
					////		rhowater_*mag(gravity_)* (CellCenters[i].component(2));
			////Cheat according to RL WIEGEL
			////Keller 1948
			//pana[i] = rhowater_*mag(gravity_)*(xi-CellCenters[i].component(2));
			
			//alpha1ana[i]=1;
			//}
	//else
	//{
		//Uana[i] = U[i]*alpha1[i];
		//alpha1ana[i] = alpha1[i];
		//pana[i] = 0.;
		//}		
//}
//}

//void Foam::wave::checkUrsell()
//{

	//Info<<"Wave data: "<<endl;
	//Info<<"Waterlevel :	"<<waterLevel_<<endl;
	//Info<<"Period 	  :	"<<Period_<<endl;
	//Info<<"WaveHeight :	"<<WaveHeight_<<endl;
	//Info<<"WaveLength :	"<<Lambda_<<endl;
	//Info<<"Ursell 	  :	"<<Ursell()<<endl;
	//Info<<"rho water  :	"<<rhowater_<<endl;
	
	
	//if (Type_ == word("sinewave")  && (WaveHeight_/Lambda_ > 0.01 || waterLevel_/Lambda_ > 1 ) )
	//{
		//Info<<"WARNING: Linear theory not suitable."<<endl;	
	//}
	//if (Type_ == word("stokes2wave") && Ursell() > 40 )
	//{
		//Info<<"WARNING: Ursell number is "<<Ursell()<<" ."<<endl;
		//Info<<"WARNING: Stokes theory not suitable."<<endl;
	//}
	//if (Type_ == word("cnoidalwave") && Ursell() < 40 )
	//{
		//Info<<"WARNING: Ursell number is "<<Ursell()<<" ."<<endl;
		//Info<<"WARNING: Cnoidal theory not suitable."<<endl;
	//}	
	//}


//// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //
//Foam::wave::wave(const volVectorField & CellCenters,volVectorField  &U, volVectorField &Uana, volScalarField &alpha1, volScalarField &alpha1ana, volScalarField &p, volScalarField &pana, volScalarField &relax ,scalar &rhowater, vector gravity)
//{
	//gravity_		= gravity;
	//gravityUnitV_ 	= gravity_/mag(gravity_);
	//rhowater_		= rhowater;
	//readDict(CellCenters,U,Uana, alpha1, alpha1ana,p, pana,   relax);
	//}


//}
// End namespace Foam
 
// ************************************************************************* //
