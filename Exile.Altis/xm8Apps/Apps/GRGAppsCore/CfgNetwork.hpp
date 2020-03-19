// CfgNetworking

class giveTakePlayerRespectRequest 
{
    module = "GRGApps";
    parameters[] = {"OBJECT","SCALAR"};
};

class giveTakePlayerRespectResponse
{
    module = "GRGApps";
    parameters[] =  {"BOOL","SCALAR"};
};

class giveTakePlayerTabsRequest 
{
    module = "GRGApps";
    parameters[] = {"OBJECT","SCALAR"};
};
class giveTakePlayerTabsResponse
{
    module = "GRGApps";
    parameters[] =  {"BOOL","SCALAR"};
};

class purchaseLevel7Request
{
    module = "GRGApps";
    parameters[] = {"OBJECT","SCALAR"};    
};

class purchaseLevel7Response 
{
    module = "GRGApps";
    parameters[] = {"BOOL","SCALAR"};
};

class updateLevel7TimeRemainingRequest
{
    module = "GRGApps";
    parameters[] = {"OBJECT","SCALAR"};
};

class updateLevel7TimeRemainingResponse 
{
    module = "GRGApps";
    parameters[] = {"SCALAR"}; 
};

class respectToTabsRequest 
{
    module = "GRGApps";
    parameters[] = {"OBJECT","SCALAR","SCALAR"};
};

class respectToTabsResponse 
{
    module = "GRGApps";
    parameters[] = {"BOOL"};
};

class purchaseAirdropWithRespectRequest 
{
    module = "GRGApps";
    parameters[] = {"OBJECT","STRING","SCALAR","STRING","SCALAR","BOOL"};
};

class purchaseAirdropResponse
{
    module = "GRGApps";
    parameters[] = {"BOOL","STRING"};
};