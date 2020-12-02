%%From the dataset convert all the atributes into a binary '0' and '1'.
dataframe = readtable("student-mat.csv")

%Convert school GP - 0; MS = 1
newschool = ConvertGP(dataframe.school)
newschool = array2table(newschool) 
dataframe = [dataframe newschool];

%Convert sex Male -0; Female -1
newsex = Convertsex(dataframe.sex)
newsex = array2table (newsex)
dataframe = [dataframe newsex];

%Convert adress Rural -0; Urban -1
newadd=Convertadd(dataframe.address)
newadd = array2table(newadd)
dataframe = [dataframe newadd];

%Convert family size Less or equal to three -0; Greater than three -1
newfam = Convertfam(dataframe.famsize)
newfam = array2table(newfam) 
dataframe = [dataframe newfam];

%Convert parent's cohabitation status Apart - 0; Together - 1
newPst = ConvertPst(dataframe.Pstatus)
newPst = array2table(newPst) 
dataframe = [dataframe newPst];

%schoolsup - Extra educational support yes -1; no -0
newschoolsup = ConvertSssup(dataframe.schoolsup)
newschoolsup = array2table(newschoolsup) 
dataframe = [dataframe newschoolsup];

% family educational support yes - 1; no - 0
newsfamsup = Convertfamsup(dataframe.famsup)
newsfamsup = array2table(newsfamsup) 
dataframe = [dataframe newsfamsup];

% extra paid classes within the course subject yes - 1; no - 0
newspaid = Convertpaid(dataframe.paid)
newspaid = array2table(newspaid) 
dataframe = [dataframe newspaid];

%extra-curricular activities yes - 1; no - 0
%%activities - Convertact
newact = Convertact(dataframe.activities)
newact = array2table(newact) 
dataframe = [dataframe newact];

%attended nursery school yes - 1; no - 0
newnurse = Convertnurse(dataframe.nursery)
newnurse = array2table(newnurse)
dataframe = [dataframe newnurse]

%wants to take higher education yes - 1; no - 0
newhigher = Converthigher(dataframe.higher)
newhigher = array2table(newhigher)
dataframe = [dataframe newhigher]

%Internet access at home yes - 1; no - 0
%%internet - Convertinternet
newint = Convertinternet(dataframe.internet)
newint = array2table(newint) 
dataframe = [dataframe newint];

%with a romantic relationship yes - 1; no - 0
%%romantic - Convertrom
newrom = Convertrom(dataframe.romantic)
newrom = array2table(newrom) 
dataframe = [dataframe newrom];

df2= dataframe
%% Delete the attribues that wil no longer be used.

df2.school = []
df2.sex = []
df2.address = []
df2.famsize = []
df2.Pstatus = []
df2.schoolsup = []
df2.famsup = []
df2.paid = []
df2.activities = []
df2.nursery = []
df2.higher = []
df2.internet = []
df2.romantic = []

%%Check until here.
df3=df2;

newage = Convertage2(df3.age)
newage = array2table(newage) 
df3 = [df3 newage];
 
% %Mother & Father education. 0- (None and primary) 1 - (secondary or higher)
newMedu = ConvertMedu(df3.Medu)  
newMedu = array2table(newMedu) 
df3 = [df3 newMedu];
 
newFedu = ConvertFedu(df3.Fedu)  
newFedu = array2table(newFedu) 
df3 = [df3 newFedu];

%%Guardian (3 options, 3 attributes, 0-no, 1- yes - father, mother, other)
newguardianother = Convertguardother(df3.guardian)
newguardianother = array2table(newguardianother)
df3 = [df3 newguardianother]

newguardianmother = Convertguardmother(df3.guardian)
newguardianmother = array2table(newguardianmother)
df3 = [df3 newguardianmother]

newguardianfather = Convertguardfather(df3.guardian)
newguardianfather = array2table(newguardianfather)
df3 = [df3 newguardianfather]


%traveltime (original 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
%traveltime ( 0 less than30 min, 1 - more than 30 min.
newtraveltime = Converttravel(df3.traveltime)
newtraveltime = array2table(newtraveltime)
df3 = [df3 newtraveltime]

%studytime - (original 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
%studytime - (0 less than 5 hours, 1 more than 5 hours)
newstudytime = Convertstudytime(df3.studytime)
newstudytime = array2table(newstudytime)
df3 = [df3 newstudytime]

% failures - (0 less than 2, 1 -2or more)
newfailures = Convertfailure(df3.failures)
newfailures = array2table(newfailures)
df3 = [df3 newfailures]

%famrel - quality of family relationships (0 - less than 2; 1 - 3 to 5)
famrelationship = Convertfnumerical(df3.famrel)
famrelationship = array2table(famrelationship)
df3 = [df3 famrelationship]

%freetime - free time after school %%(0 - less than 2; 1 - 3 to 5)
newfreetime = Convertfnumerical(df3.freetime)
newfreetime = array2table(newfreetime)
df3 = [df3 newfreetime]

% %goout - going out with friends (0 - less than 2; 1 - 3 to 5)
newgoout = Convertfnumerical(df3.goout)
newgoout = array2table(newgoout)
df3 = [df3 newgoout]

%Dalc - workday alcohol consumption (0 - less than 2; 1 - 3 to 5)
walcohol = Convertfnumerical(df3.Dalc)
walcohol = array2table(walcohol)
df3 = [df3 walcohol]

%Walc - weekend alcohol consumption (0 - less than 2; 1 - 3 to 5)
wkalcohol = Convertfnumerical(df3.Walc)
wkalcohol = array2table(wkalcohol)
df3 = [df3 wkalcohol]

%health - current health status (0 - less than 2; 1 - 3 to 5)
newhealth = Convertfnumerical(df3.health)
newhealth = array2table(newhealth)
df3 = [df3 newhealth]

%absences - number of school absences 
%(0 - below average, 1 from average above) Average 5.708860759
averageabsences = Convertgmean(df3.absences)
averageabsences = array2table(averageabsences)
df3 = [df3 averageabsences]

%G1 - number of school absences 
%(0 - below average, 1 from average above) Average 10.90886076
averageg1 = Convertgmean(df3.G1)
averageg1 = array2table(averageg1)
df3 = [df3 averageg1]

%G2 - number of school absences 
%(0 - below average, 1 from average above) Average 10.71392405
averageg2 = Convertgmean(df3.G2)
averageg2 = array2table(averageg2)
df3 = [df3 averageg2]


% %%Mother and Father Job
% %nominal: "teacher", "health" care related, civil "services" 
% %(e.g. administrative or police), "at_home" or "other")
 
Mjobteacher = Converteacher(df3.Mjob)
Mjobteacher = array2table(Mjobteacher)
df3 = [df3 Mjobteacher]
 
Mjobhealth = Converthealth(df3.Mjob)
Mjobhealth = array2table(Mjobhealth)
df3 = [df3 Mjobhealth]
 
Mjobservices = Convertservices(df3.Mjob)
Mjobservices = array2table(Mjobservices)
df3 = [df3 Mjobservices]
 
Mjobathome = Convertathome(df3.Mjob)
Mjobathome = array2table(Mjobathome)
df3 = [df3 Mjobathome]
 
Mjobother = Convertguardother(df3.Mjob)
Mjobother = array2table(Mjobother)
df3 = [df3 Mjobother]
 
Fjobteacher =Converteacher(df3.Fjob)
Fjobteacher = array2table(Fjobteacher)
df3 = [df3 Fjobteacher]
 
Fjobhealth = Converthealth(df3.Fjob)
Fjobhealth = array2table(Fjobhealth)
df3 = [df3 Fjobhealth]
 
Fjobservices = Convertservices(df3.Fjob)
Fjobservices = array2table(Fjobservices)
df3 = [df3 Fjobservices]
 
Fjobathome = Convertathome(df3.Fjob)
Fjobathome = array2table(Fjobathome)
df3 = [df3 Fjobathome]
 
Fjobother = Convertguardother(df3.Fjob)
Fjobother = array2table(Fjobother)
df3 = [df3 Fjobother]

%reason to choose this school
%nominal:close to "home", "reputation", "course" preference or "other"

reasonhome = Converthome(df3.reason) 
reasonhome = array2table(reasonhome)
df3 = [df3 reasonhome]

reasonreputation = Convertreputation(df3.reason)
reasonreputation = array2table(reasonreputation)
df3 = [df3 reasonreputation]

reasoncourse = Convertcourse(df3.reason)
reasoncourse = array2table(reasoncourse)
df3 = [df3 reasoncourse]

reasonother = Convertguardother(df3.reason)
reasonother = array2table(reasonother)
df3 = [df3 reasonother]

%%%Delete the original attributes in a new dataframe
df4=df3

df4.age = []
df4.Medu = []
df4.Fedu = []
df4.guardian = []
df4.traveltime = []
df4.studytime = []
df4.failures = []
df4.famrel = []
df4.freetime = []
df4.goout = []
df4.Dalc = []
df4.Walc = []
df4.health = []
df4.absences = []
df4.G1 = []
df4.G2 = []
df4.Mjob = []
df4.Fjob = []
df4.reason = []

writetable(df4,"newbinary.csv")
