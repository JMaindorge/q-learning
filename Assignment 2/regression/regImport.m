opts = spreadsheetImportOptions("NumVariables", 46);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:AT396";

% Specify column names and types
opts.VariableNames = ["G3", "newschool", "newsex", "newadd", "newfam", "newPst", "newschoolsup", "newsfamsup", "newspaid", "newact", "newnurse", "newhigher", "newint", "newrom", "newage", "newMedu", "newFedu", "newguardianother", "newguardianmother", "newguardianfather", "newtraveltime", "newstudytime", "newfailures", "famrelationship", "newfreetime", "newgoout", "walcohol", "wkalcohol", "newhealth", "averageabsences", "averageg1", "averageg2", "Mjobteacher", "Mjobhealth", "Mjobservices", "Mjobathome", "Mjobother", "Fjobteacher", "Fjobhealth", "Fjobservices", "Fjobathome", "Fjobother", "reasonhome", "reasonreputation", "reasoncourse", "reasonother"];
opts.VariableTypes = ["char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char"];

% Specify variable properties
opts = setvaropts(opts, ["G3", "newschool", "newsex", "newadd", "newfam", "newPst", "newschoolsup", "newsfamsup", "newspaid", "newact", "newnurse", "newhigher", "newint", "newrom", "newage", "newMedu", "newFedu", "newguardianother", "newguardianmother", "newguardianfather", "newtraveltime", "newstudytime", "newfailures", "famrelationship", "newfreetime", "newgoout", "walcohol", "wkalcohol", "newhealth", "averageabsences", "averageg1", "averageg2", "Mjobteacher", "Mjobhealth", "Mjobservices", "Mjobathome", "Mjobother", "Fjobteacher", "Fjobhealth", "Fjobservices", "Fjobathome", "Fjobother", "reasonhome", "reasonreputation", "reasoncourse", "reasonother"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["G3", "newschool", "newsex", "newadd", "newfam", "newPst", "newschoolsup", "newsfamsup", "newspaid", "newact", "newnurse", "newhigher", "newint", "newrom", "newage", "newMedu", "newFedu", "newguardianother", "newguardianmother", "newguardianfather", "newtraveltime", "newstudytime", "newfailures", "famrelationship", "newfreetime", "newgoout", "walcohol", "wkalcohol", "newhealth", "averageabsences", "averageg1", "averageg2", "Mjobteacher", "Mjobhealth", "Mjobservices", "Mjobathome", "Mjobother", "Fjobteacher", "Fjobhealth", "Fjobservices", "Fjobathome", "Fjobother", "reasonhome", "reasonreputation", "reasoncourse", "reasonother"], "EmptyFieldRule", "auto");

% Import the data
dataframebinary = readtable("dataframebinary.xlsx", opts, "UseExcel", false);
dataframebinary = table2cell(dataframebinary);
numIdx = cellfun(@(x) ~isnan(str2double(x)), dataframebinary);
dataframebinary(numIdx) = cellfun(@(x) {str2double(x)}, dataframebinary(numIdx));
clear opts
y=dataframebinary(:,1);
x=dataframebinary(:,2:45);