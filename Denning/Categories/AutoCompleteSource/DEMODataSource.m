//
//  DEMODataSource.m
//  MLPAutoCompleteDemo
//
//  Created by Eddy Borja on 5/28/14.
//  Copyright (c) 2014 Mainloop. All rights reserved.
//

#import "DEMODataSource.h"
#import "DEMOCustomAutoCompleteObject.h"
#import "AFHTTPSessionOperation.h"

@interface DEMODataSource ()
@property(strong,nonatomic) NSOperationQueue *fetchQueue;

@property (strong, nonatomic) NSArray *countryObjects;

@end


@implementation DEMODataSource
@synthesize manager;


#pragma mark - MLPAutoCompleteTextField DataSource

- (NSArray*) parseResponse: (id) response
{
    NSMutableArray* keywords = [NSMutableArray new];
    for (id obj in response) {
        [keywords addObject:[obj objectForKey:@"keyword"]];
    }
    
    return keywords;
}

//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    if ([NSOperationQueue mainQueue].operationCount > 0) {
        [[NSOperationQueue mainQueue] cancelAllOperations];
    }
    
    
    self.manager = [[AFHTTPSessionManager  alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.requestSerializer.timeoutInterval= 100;
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.manager.requestSerializer setValue:@"testdenningSkySea" forHTTPHeaderField:@"webuser-sessionid"];
    [self.manager.requestSerializer setValue:@"SkySea@denning.com.my" forHTTPHeaderField:@"webuser-id"];

    NSString* url = [@"http://43.252.215.163/denningwcf/v1/generalSearch/keyword?search=" stringByAppendingString:[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    NSOperation *operation = [AFHTTPSessionOperation operationWithManager:manager
                                                               HTTPMethod:@"GET"
                                                                URLString:url
                                                               parameters:nil
                                                           uploadProgress:nil
                                                         downloadProgress:nil
                                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                                      NSLog(@"%@", responseObject);
                                                                      
                                                                      handler([self parseResponse:responseObject]);                     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                              NSLog(@"%@", error);
                                                                  }];
    [[NSOperationQueue mainQueue] addOperation:operation];
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//    dispatch_async(queue, ^{
//        if(self.simulateLatency){
//            CGFloat seconds = arc4random_uniform(4)+arc4random_uniform(4); //normal distribution
//            NSLog(@"sleeping fetch of completions for %f", seconds);
//            sleep(seconds);
//        }
//        
//        NSArray *completions;
//        if(self.testWithAutoCompleteObjectsInsteadOfStrings){
//            completions = [self allCountryObjects];
//        } else {
//            completions = [self allCountries];
//        }
//        
//        handler(completions);
//    });
}

/*
 - (NSArray *)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
 {
 
 if(self.simulateLatency){
 CGFloat seconds = arc4random_uniform(4)+arc4random_uniform(4); //normal distribution
 NSLog(@"sleeping fetch of completions for %f", seconds);
 sleep(seconds);
 }
 
 NSArray *completions;
 if(self.testWithAutoCompleteObjectsInsteadOfStrings){
 completions = [self allCountryObjects];
 } else {
 completions = [self allCountries];
 }
 
 return completions;
 }
 */

- (NSArray *)allCountryObjects
{
    if(!self.countryObjects){
        NSArray *countryNames = [self allCountries];
        NSMutableArray *mutableCountries = [NSMutableArray new];
        for(NSString *countryName in countryNames){
            DEMOCustomAutoCompleteObject *country = [[DEMOCustomAutoCompleteObject alloc] initWithCountry:countryName];
            [mutableCountries addObject:country];
        }
        
        [self setCountryObjects:[NSArray arrayWithArray:mutableCountries]];
    }
    
    return self.countryObjects;
}


- (NSArray *)allCountries
{
    NSArray *countries =
    @[
      @"Abkhazia",
      @"Afghanistan",
      @"Aland",
      @"Albania",
      @"Algeria",
      @"American Samoa",
      @"Andorra",
      @"Angola",
      @"Anguilla",
      @"Antarctica",
      @"Antigua & Barbuda",
      @"Argentina",
      @"Armenia",
      @"Aruba",
      @"Australia",
      @"Austria",
      @"Azerbaijan",
      @"Bahamas",
      @"Bahrain",
      @"Bangladesh",
      @"Barbados",
      @"Belarus",
      @"Belgium",
      @"Belize",
      @"Benin",
      @"Bermuda",
      @"Bhutan",
      @"Bolivia",
      @"Bosnia & Herzegovina",
      @"Botswana",
      @"Brazil",
      @"British Antarctic Territory",
      @"British Virgin Islands",
      @"Brunei",
      @"Bulgaria",
      @"Burkina Faso",
      @"Burundi",
      @"Cambodia",
      @"Cameroon",
      @"Canada",
      @"Cape Verde",
      @"Cayman Islands",
      @"Central African Republic",
      @"Chad",
      @"Chile",
      @"China",
      @"Christmas Island",
      @"Cocos Keeling Islands",
      @"Colombia",
      @"Commonwealth",
      @"Comoros",
      @"Cook Islands",
      @"Costa Rica",
      @"Cote d'Ivoire",
      @"Croatia",
      @"Cuba",
      @"Cyprus",
      @"Czech Republic",
      @"Democratic Republic of the Congo",
      @"Denmark",
      @"Djibouti",
      @"Dominica",
      @"Dominican Republic",
      @"East Timor",
      @"Ecuador",
      @"Egypt",
      @"El Salvador",
      @"England",
      @"Equatorial Guinea",
      @"Eritrea",
      @"Estonia",
      @"Ethiopia",
      @"European Union",
      @"Falkland Islands",
      @"Faroes",
      @"Fiji",
      @"Finland",
      @"France",
      @"Gabon",
      @"Gambia",
      @"Georgia",
      @"Germany",
      @"Ghana",
      @"Gibraltar",
      @"GoSquared",
      @"Greece",
      @"Greenland",
      @"Grenada",
      @"Guam",
      @"Guatemala",
      @"Guernsey",
      @"Guinea Bissau",
      @"Guinea",
      @"Guyana",
      @"Haiti",
      @"Honduras",
      @"Hong Kong",
      @"Hungary",
      @"Iceland",
      @"India",
      @"Indonesia",
      @"Iran",
      @"Iraq",
      @"Ireland",
      @"Isle of Man",
      @"Israel",
      @"Italy",
      @"Jamaica",
      @"Japan",
      @"Jersey",
      @"Jordan",
      @"Kazakhstan",
      @"Kenya",
      @"Kiribati",
      @"Kosovo",
      @"Kuwait",
      @"Kyrgyzstan",
      @"Laos",
      @"Latvia",
      @"Lebanon",
      @"Lesotho",
      @"Liberia",
      @"Libya",
      @"Liechtenstein",
      @"Lithuania",
      @"Luxembourg",
      @"Macau",
      @"Macedonia",
      @"Madagascar",
      @"Malawi",
      @"Malaysia",
      @"Maldives",
      @"Mali",
      @"Malta",
      @"Mars",
      @"Marshall Islands",
      @"Mauritania",
      @"Mauritius",
      @"Mayotte",
      @"Mexico",
      @"Micronesia",
      @"Moldova",
      @"Monaco",
      @"Mongolia",
      @"Montenegro",
      @"Montserrat",
      @"Morocco",
      @"Mozambique",
      @"Myanmar",
      @"Nagorno Karabakh",
      @"Namibia",
      @"NATO",
      @"Nauru",
      @"Nepal",
      @"Netherlands Antilles",
      @"Netherlands",
      @"New Caledonia",
      @"New Zealand",
      @"Nicaragua",
      @"Niger",
      @"Nigeria",
      @"Niue",
      @"Norfolk Island",
      @"North Korea",
      @"Northern Cyprus",
      @"Northern Mariana Islands",
      @"Norway",
      @"Olympics",
      @"Oman",
      @"Pakistan",
      @"Palau",
      @"Palestine",
      @"Panama",
      @"Papua New Guinea",
      @"Paraguay",
      @"Peru",
      @"Philippines",
      @"Pitcairn Islands",
      @"Poland",
      @"Portugal",
      @"Puerto Rico",
      @"Qatar",
      @"Red Cross",
      @"Republic of the Congo",
      @"Romania",
      @"Russia",
      @"Rwanda",
      @"Saint Barthelemy",
      @"Saint Helena",
      @"Saint Kitts & Nevis",
      @"Saint Lucia",
      @"Saint Vincent & the Grenadines",
      @"Samoa",
      @"San Marino",
      @"Sao Tome & Principe",
      @"Saudi Arabia",
      @"Scotland",
      @"Senegal",
      @"Serbia",
      @"Seychelles",
      @"Sierra Leone",
      @"Singapore",
      @"Slovakia",
      @"Slovenia",
      @"Solomon Islands",
      @"Somalia",
      @"Somaliland",
      @"South Africa",
      @"South Georgia & the South Sandwich Islands",
      @"South Korea",
      @"South Ossetia",
      @"South Sudan",
      @"Spain",
      @"Sri Lanka",
      @"Sudan",
      @"Suriname",
      @"Swaziland",
      @"Sweden",
      @"Switzerland",
      @"Syria",
      @"Taiwan",
      @"Tajikistan",
      @"Tanzania",
      @"Thailand",
      @"Togo",
      @"Tonga",
      @"Trinidad & Tobago",
      @"Tunisia",
      @"Turkey",
      @"Turkmenistan",
      @"Turks & Caicos Islands",
      @"Tuvalu",
      @"Uganda",
      @"Ukraine",
      @"United Arab Emirates",
      @"United Kingdom",
      @"United Nations",
      @"United States",
      @"Uruguay",
      @"US Virgin Islands",
      @"Uzbekistan",
      @"Vanuatu",
      @"Vatican City",
      @"Venezuela",
      @"Vietnam",
      @"Wales",
      @"Western Sahara",
      @"Yemen",
      @"Zambia",
      @"Zimbabwe"
      ];
    
    return countries;
}





@end
