//
//  APIManager.m
//  DTE
//
//  Created by Divya Jain on 5/8/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "APIManager.h"
#import "Reachability.h"
@implementation APIManager

+(instancetype)sharedManager
{
    static APIManager*sharedManager = nil;
    static dispatch_once_t onceToken;
    
    // execute initialization exactly once
    dispatch_once(&onceToken, ^{
        sharedManager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://demo.downtoearthorganicfood.com/mobileservice.asmx/"]];
    });
    return sharedManager;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
        self.categories = [[NSArray alloc] init];

    }
    return self;
}

-(void)registerUser:(User*)user completionBlock:(APIinfoCompletionBlock)block
{
    // API: GET /mobileservice.asmx/Register?Email=string&Password=string&FirstName=string&LastName=string&Mobile=string HTTP/1.1

    
    NSString *requestURL =[NSString stringWithFormat:@"Register?Email=%@&Password=%@&FirstName=%@&LastName=%@&Mobile=%@",user.email,user.password,user.fName,user.lName,user.mobile];

    
//    [self POSTInfoRequestWithUrlString:requestURL userINFO:user completionBlock:block];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];
}


-(void)signInUser:(User*)user completionBlock:(APIinfoCompletionBlock)block
{
    
//    GET /mobileservice.asmx/Login?Email=string&Password=string

    NSString *requestURL =[NSString stringWithFormat:@"Login?&Email=%@&Password=%@",user.email,user.password];

    [self GETInfoRequestWithUrlString:requestURL userINFO:user completionBlock:block];
//    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];


}

-(void)GETInfoRequestWithUrlString:(NSString*)urlString userINFO:(User*)user completionBlock:(APIinfoCompletionBlock)block
{
    
    
    
    [self GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(responseObject, nil);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }
        
    }];
    
}



-(void)POSTInfoRequestWithUrlString:(NSString*)urlString userINFO:(User*)user completionBlock:(APIinfoCompletionBlock)block
{

   

    [self POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(responseObject, nil);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }

    }];

}


-(void)getAllCategories
{
//    GET /mobileservice.asmx/GetAllCategories? HTTP/1.1
     NSString *requestURL =[NSString stringWithFormat:@"GetAllCategories?"];
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:nil];

}

-(void)getAllStates
{
    //    GET /mobileservice.asmx/GetAllCategories? HTTP/1.1
    NSString *requestURL =[NSString stringWithFormat:@"GetStateList?CountryId=41"];
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:nil];
    
}


-(void)getAllCategoriesWithCompletionHandler:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"GetAllCategories?"];

    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];
    
}

-(void)getAllBannerWithCompletionHandler:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"GetBanner?"];
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];
    
}



-(void)getProductsByCategoryID:(NSString*)categoryID withCompletionBlock:(APIinfoCompletionBlock)block
{
//    GET /mobileservice.asmx/GetProductsByCategoryId?CategoryId=string

    NSString *requestURL =[NSString stringWithFormat:@"GetProductsByCategoryId?CategoryId=%@",categoryID];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];

}

-(void)getProductDetailByProductID:(NSString*)productID withCompletionBlock:(APIinfoCompletionBlock)block
{
//    GET /mobileservice.asmx/GetProductDetailByByProductId?ProductId=string

    
    NSString *requestURL =[NSString stringWithFormat:@"GetProductDetailByByProductId?ProductId=%@",productID];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];


}


-(void)removeProduct:(NSString*)ShoppingCartItemId withCompletionBlock:(APIinfoCompletionBlock)block
{
    //GET /mobileservice.asmx/DeleteCartItem?CustomerId=string&ShoppingCartItemId=string


    
    NSString *requestURL =[NSString stringWithFormat:@"DeleteCartItem?CustomerId=%@&ShoppingCartItemId=%@",@"8931",ShoppingCartItemId];
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];
    
}


-(void)addToCartForProduct:(NSMutableDictionary *)productToAdd withCompletionBlock:(APIinfoCompletionBlock)block
{
//    GET /mobileservice.asmx/AddToCart?CustomerId=string&ProductVariantAttributeValueID=string&ProductVeriantID=string&Qty=string&Weight=string
    
//    http://demo.downtoearthorganicfood.com/mobileservice.asmx/AddToCart?CustomerId=8931&ProductVariantAttributeValueID=674&ProductVeriantID=108&Qty=1&Weight=1
    
   NSString *requestURL =[NSString stringWithFormat:@"AddToCart?CustomerId=%@&ProductVariantAttributeValueID=%@&ProductVeriantID=%@&Qty=%@&Weight=%@",productToAdd[@"CustomerId"],productToAdd[@"ProductVariantAttributeValueID"],productToAdd[@"ProductVariantID"],productToAdd[@"Qty"],productToAdd[@"Weight"]];
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];

}

-(void)AddOrderWithOrderInfo:(NSMutableDictionary*)orderInfo
         withCompletionBlock:(APIinfoCompletionBlock)block
{
//    GET /mobileservice.asmx/AddOrder?CustomerId=string&AdvanceAmount=string&BillingAddressId=string&BillingFirstName=string&BillingLastName=string&BillingEmail=string&BillingAddress1=string&BillingAddress2=string&BillingCity=string&BillingStateProvinceId=string&BillingZipPostalCode=string&BillingCountryId=string&BillingMobileNo=string&ShippingAddressId=string&ShippingFirstName=string&ShippingLastName=string&ShippingEmail=string&ShippingAddress1=string&ShippingAddress2=string&ShippingCity=string&ShippingStateProvinceId=string&ShippingZipPostalCode=string&ShippingCountryId=string&ShippingMobileNo=string HTTP/1.1

    NSString *requestURL =[NSString stringWithFormat:@"AddOrder?CustomerId=%@&AdvanceAmount=%@&BillingAddressId=%@&BillingFirstName=%@&BillingLastName=%@&BillingEmail=%@&BillingAddress1=%@&BillingAddress2=%@&BillingCity=%@&BillingStateProvinceId=%@&BillingZipPostalCode=%@&BillingCountryId=%@&BillingMobileNo=%@&ShippingAddressId=%@&ShippingFirstName=%@&ShippingLastName=%@&ShippingEmail=%@&ShippingAddress1=%@&ShippingAddress2=%@&ShippingCity=%@&ShippingStateProvinceId=%@&ShippingZipPostalCode=%@&ShippingCountryId=%@&ShippingMobileNo=%@",
                           [[User sharedUser] customerId],orderInfo[@"AdvanceAmount"],orderInfo[@"BillingAddressId"],orderInfo[@"BillingFirstName"],orderInfo[@"BillingLastName"],orderInfo[@"BillingEmail"],orderInfo[@"BillingAddress1"],orderInfo[@"BillingAddress2"],orderInfo[@"BillingCity"],orderInfo[@"BillingStateProvinceId"],orderInfo[@"BillingZipPostalCode"],orderInfo[@"BillingCountryId"],orderInfo[@"BillingMobileNo"],orderInfo[@"ShippingAddressId"],orderInfo[@"ShippingFirstName"],orderInfo[@"ShippingLastName"],orderInfo[@"ShippingEmail"],orderInfo[@"ShippingAddress1"],orderInfo[@"ShippingAddress2"],orderInfo[@"ShippingCity"],orderInfo[@"ShippingStateProvinceId"],orderInfo[@"ShippingZipPostalCode"],orderInfo[@"ShippingCountryId"],orderInfo[@"ShippingMobileNo"]];
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];
 
    

}

-(void)searchProductByKeywords:(NSString*)keywords withCompletionBlock:(APIinfoCompletionBlock)block
{
//    GET /mobileservice.asmx/Search?keywords=string
    NSString *requestURL =[NSString stringWithFormat:@"Search?keywords=%@",keywords];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];
    
}

-(void)GetCartByCustomerId:(NSString*)customerID withCompletionBlock:(APIinfoCompletionBlock)block
{
//    GET /mobileservice.asmx/GetCartByCustomerId?CustomerId=string HTTP/1.1
    NSString *requestURL =[NSString stringWithFormat:@"GetCartByCustomerId?CustomerId=%@",customerID];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];

}

-(void)GetMyOrdersByCustomerID:(NSString*)customerID withCompletionBlock:(APIinfoCompletionBlock)block
{
//    GET /mobileservice.asmx/GetCustomerOrders?CustomerId=string
    NSString *requestURL =[NSString stringWithFormat:@"GetCustomerOrders?CustomerId=%@",customerID];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];

}

-(void)GetMyOrdersWithCompletionBlock:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"GetCustomerOrders?CustomerId=%@",[[User sharedUser] customerId]];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];
    
}

-(void)GetShippingAddresseWithCompletionBlock:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"GetShippingAddress?CustomerId=%@",[[User sharedUser] customerId]];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];

}
-(void)GetBillingAddressesWithCompletionBlock:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"GetBillingAddress?CustomerId==%@",[[User sharedUser] customerId]];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];

}

-(void)UpdateCartItemForCartItemID:(NSString*)cartItemID Quantity:(NSString*)quantity withCompletionBlock:(APIinfoCompletionBlock)block
{
    NSString *requestURL =[NSString stringWithFormat:@"UpdateCartItem?CustomerId=%@&ShoppingCartItemId=%@&Quantity=%@",[[User sharedUser] customerId],cartItemID,quantity];
    
    [self GETInfoRequestWithURLString:requestURL param:nil completionBlock:block];
    

}

-(void)GETInfoRequestWithURLString:(NSString*)urlString param:(NSDictionary*)param completionBlock:(APIinfoCompletionBlock)block
{

    [self GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([urlString isEqualToString:@"GetAllCategories?"]) {
        self.categories = responseObject;
    }
        if ([urlString isEqualToString:@"GetStateList?CountryId=41"]) {
            self.stateList = responseObject;
        }

    if (block) {
        block(responseObject, nil);
    }

    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (block) {
        block(nil, error);
    }

}];

}
+(BOOL)isNetworkAvailable
{
    
    BOOL isOnline = YES;
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    switch (myStatus) {
        case NotReachable:
            NSLog(@"There's no internet connection at all. Display error message now.");
            isOnline = NO;
            break;
            
        case ReachableViaWWAN:
            //            NSLog(@"We have a 3G connection");
            break;
            
        case ReachableViaWiFi:
            //            NSLog(@"We have WiFi.");
            break;
            
        default:
            break;
    }
    return isOnline;
    
}


@end
