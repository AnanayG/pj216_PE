
int ArraySize = 5;

int IConstant = 7;
int I1[ArraySize];
int I2[ArraySize];
int I3[ArraySize];

int Output = 0;
//Function 1-------------------------------------------
//Title: DelayLine
//Latency = 2
for(int idx = 0; idx < ArraySize; idx++)
{
    Output = I1[idx];
}

//Function 2-------------------------------------------
//Title: DelayLine II
//Latency = 4
Output = 0;
for (int idx = 0; idx < ArraySize; idx++)
{
    Output = I1[idx];
}

//Function 3-------------------------------------------
//Title: Addition
//Latency = 2
Output = 0;
for (int idx = 0; idx < ArraySize; idx++)
{
    Output = I2[idx] + I3[idx];
}

//Function 4-------------------------------------------
//Title: Multiplication
//Latency = 2
Output = 0;
for (int idx = 0; idx < ArraySize; idx++)
{
    Output = I1[idx] * I2[idx];
}

//Function 5-------------------------------------------
//itle: MAC
//Latency = 2
Output = 0;
for (int idx = 0; idx < ArraySize; idx++)
{
    Output = I1[idx] + I2[idx] * I3[idx];
}

//Function 6-------------------------------------------
//Title: Constant MAC
//Latency = 2
Output = 0;
for (int idx = 0; idx < ArraySize; idx++)
{
    Output = Output + I3[idx] * IConstant;
}

//Function 7-------------------------------------------
//Title: Kernel Mac
//Latency = 4
Output = 0;
for (int idx = 1; idx < ArraySize - 1; idx++)
{
    Output = I1[idx-1] * I1[idx] + I1[idx+1];
}

//Function 8-------------------------------------------
//Title: Data Dependency
//Latency = 6
Output = 0;
int temp[ArraySize];
for (int idx = 0; idx < ArraySize - 2; idx++)
{
    temp[idx] = I1[idx] * I1[idx + 1];
}
for (int idx = 0; idx < ArraySize - 2; idx++)
{
    Output = Output + temp[idx + 2];
}