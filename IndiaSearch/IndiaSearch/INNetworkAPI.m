//
//  INNetworkAPI.m
//  IndiaSearch
//
//  Created by Manu Sharma on 1/18/13.
//  Copyright (c) 2013 Manu Sharma. All rights reserved.
//

#import "INNetworkAPI.h"
#import "INProperties.h"

@interface INNetworkAPI ()

@end

@implementation INNetworkAPI

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (NSMutableURLRequest *)buildServerRequestWithOp:(NSString *)op data:(NSData *)postData
{
    NSString *opUrl = [SERVER_USER stringByAppendingString:op];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:opUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    return request;
}

- (id)generalFinishHandler:(NSURLResponse *)response data:(NSData *)data error:(NSError *)anError
{
    // This should only happen when we have a network or server error. In any case, fatal
    if (anError)
    {
       // DDLogError(@"%s: Fatal: getUserByMembership error:\n%@", __func__, anError);
        NSDictionary *d = [NSDictionary dictionaryWithObject:@"Network Failure"
                                                      forKey:NO_NETWORK_MESSAGE_NAME];
        [[NSNotificationCenter defaultCenter] postNotificationName:NO_NETWORK_MESSAGE_NAME
                                                            object:nil
                                                          userInfo:d];
        return nil;
    }
    
    // parse what should be json data
    NSError *error = nil;
    NSDictionary *r = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    // The following only happens if we have a coding error. This should never happen outside of development
    if (error)
    {
        //DDLogError(@"%s: Error with json serialization %@", __func__, error);
        //DDLogError(@"%s: \n\ndata was\n%@", __func__, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary *d = [NSDictionary dictionaryWithObject:@"Error from server"
                                                      forKey:NO_NETWORK_MESSAGE_NAME];
        [[NSNotificationCenter defaultCenter] postNotificationName:NO_NETWORK_MESSAGE_NAME
                                                            object:nil
                                                          userInfo:d];
        return nil;
    }
    
    // Now look at the JSON data, and see if we succeeded (Messages should be empty)
    NSArray *msgs = [r objectForKey:@"Messages"];
    if ([msgs count] > 0)
    {
        //DDLogInfo(@"%s: messages from server:\n%@", __func__, msgs);
        return nil;
    }
    return r;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
