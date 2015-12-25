//
//  AFSTests.m
//  AFSTests
//
//  Created by azat on 12/12/15.
//  Copyright © 2015 azat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Specta.h>
#import "TUSEmployee.h"
#import <Expecta/Expecta.h>
#import "TUSCompany.h"
#import "TUSTaxman.h"

@interface TUSEmployee()

- (void)payTaxes;

@end


SpecBegin(AFTests)

__block TUSEmployee *employee;

describe(@"my tests", ^{
   
    beforeEach(^{
        employee = [TUSEmployee new];
    });

    it(@"returns best salary", ^{
        employee.salaryHistory = @[@42,@74,@6,@78];
        NSNumber *best = @78;
        expect(best).equal(@78);
    });
    
    it(@"pays", ^{
        TUSCompany *company = [TUSCompany new];
        
        employee.currentSalary = @10;
        employee.totalAmount = @0;

        [company payToEmployee:employee];
        expect(employee.totalAmount).beGreaterThan(@0);
    });
    
    it(@"pays taxes", ^{
        TUSCompany *company = [TUSCompany new];
        
        id mock = OCMPartialMock(employee);
        
        OCMExpect([mock payTaxes]);
        
        [company payToEmployee:mock];
        
        OCMVerifyAllWithDelay(mock, 0.5);
    });

    it(@"taxes payment", ^{
        id protocolMock = OCMProtocolMock(@protocol(TUSTaxesProvider));
        [OCMStub([protocolMock baseTaxes]) andReturn:@13];
        [OCMStub([protocolMock retireInsuranceTaxes]) andReturn:@35];
        
        TUSCompany *company = [TUSCompany new];
        company.taxesProvider = protocolMock;
        company.totalAmount = @10000;
        
        employee.taxesProvider = protocolMock;
        employee.totalAmount = @0;
        employee.currentSalary = @100;
        
        TUSTaxman *taxman = [TUSTaxman new];
        company.taxman = taxman;
        employee.taxman = taxman;
        
        [company payToEmployee:employee];
        
       // NSLog(@"%@", company.totalAmount);
        //NSLog(@"%@", employee.totalAmount);
        
        expect(company.totalAmount).equal(@9865);
        expect(employee.totalAmount).equal(@87);
        
    });
});

SpecEnd
