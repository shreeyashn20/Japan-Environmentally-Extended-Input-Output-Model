# Japan-Environmentally-Extended-Input-Output-Model

## Purpose:

This code analyzes the interdependencies between economic sectors in Japan, incorporating environmental extensions.
It calculates the total output of each sector required to meet a given final demand, while considering the environmental impacts associated with production processes.

## Key Components:

1. Sets and Parameters:

Set i 'sector' /S1*S20/: Defines a set of 20 sectors, labeled S1 to S20, representing different economic activities.
Parameter t(i,*): Represents the input-output matrix, where t(i,j) indicates the amount of sector i's output required as input by sector j.
It's initially empty and loaded from an external Excel file (JAPANINPUT_V2.xlsx) using GAMS commands.
Parameter d(i) /S1*S20 = 100/: Sets a final demand of 100 units for each sector.
2. Variables:

Variable x(i): Represents the total output of sector i.
Variable dummy: A dummy variable used for linear programming optimization.
3. Equations:

*Equation e1(i).. x(i) - sum(j, t(i,j)x(j)) =e= d(i): Ensures that the total output of each sector (x(i)) meets its final demand (d(i)), considering intermediate inputs from other sectors (t(i,j)*x(j)).
Equation edum.. dummy =e= 0: A placeholder equation for the linear programming model.
4. Model and Solution:

Model m /all/: Creates a model containing all defined sets, parameters, variables, and equations.
Solve m using lp minimizing dummy: Solves the linear programming model, minimizing the dummy variable (which has no practical effect) to find a feasible solution for sector outputs (x(i)).
5. Output:

display x.l: Displays the calculated optimal values of sector outputs (x(i)).
display d: Displays the final demand values (d(i)) for reference.

## Additional Notes:

The specific environmental extensions incorporated in the model are not explicitly visible in this code snippet and likely reside in the external data file (JAPANINPUT_V2.xlsx).
Understanding the structure of the input-output matrix (t(i,j)) and the environmental extensions is crucial for interpreting the results and drawing meaningful conclusions.