//
//  APIManager.h
//  DTE
//
//  Created by Divya Jain on 5/8/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

//#define GetCartAPI @"GetCartByCustomerId?CustomerId=%@"

typedef enum {
    DTEAPIGetCartItems      = 1,
    DTEAPIAddToCart,
    DTEAPIRemoveProductFromCart,
} DTEAPIType;

typedef void(^APIinfoCompletionBlock)(_Nullable id response,NSError *_Nullable error );

@interface APIManager : AFHTTPSessionManager

@property(nonatomic,strong) NSArray* categories;
@property(nonatomic,strong) NSArray* stateList;
@property(nonatomic,strong) NSArray* cartItems;



+(instancetype)sharedManager;
+(BOOL)isNetworkAvailable;

-(void)registerUser:(User*)user completionBlock:(APIinfoCompletionBlock)block;

-(void)signInUser:(User*)user completionBlock:(APIinfoCompletionBlock)block;
-(void)getAllBannerWithCompletionHandler:(APIinfoCompletionBlock)block;
-(void)getAllCategories;
-(void)getAllStates;
-(void)getAllCategoriesWithCompletionHandler:(APIinfoCompletionBlock)block;

-(void)getProductsByCategoryID:(NSString*)categoryID withCompletionBlock:(APIinfoCompletionBlock)block;
-(void)getProductDetailByProductID:(NSString*)productID withCompletionBlock:(APIinfoCompletionBlock)block;
-(void)addToCartForProduct:(NSDictionary*)productToAdd withCompletionBlock:(APIinfoCompletionBlock)block;
-(void)searchProductByKeywords:(NSString*)keywords withCompletionBlock:(APIinfoCompletionBlock)block;
-(void)GetCartWithCompletionBlock:(APIinfoCompletionBlock)block;
-(void)GetMyOrdersByCustomerID:(NSString*)customerID withCompletionBlock:(APIinfoCompletionBlock)block;
-(void)GetShippingAddresseWithCompletionBlock:(APIinfoCompletionBlock)block;
-(void)GetBillingAddressesWithCompletionBlock:(APIinfoCompletionBlock)block;
-(void)GetMyOrdersWithCompletionBlock:(APIinfoCompletionBlock)block;
-(void)UpdateCartItemForCartItemID:(NSString*)cartItemID Quantity:(NSString*)quantity withCompletionBlock:(APIinfoCompletionBlock)block;
-(void)AddOrderWithOrderInfo:(NSMutableDictionary*)orderInfo
   withCompletionBlock:(APIinfoCompletionBlock)block;




-(void)GETInfoRequestWithUrlString:(NSString*)urlString userINFO:(User*)user completionBlock:(APIinfoCompletionBlock)block;
-(void)removeProduct:(NSString*)ShoppingCartItemId withCompletionBlock:(APIinfoCompletionBlock)block;


@end
NS_ASSUME_NONNULL_END
