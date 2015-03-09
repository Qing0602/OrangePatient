//
//  DeviceCommand.h
//  DeviceCommand
//
//  Created by contec on 14-8-29.
//  Copyright (c) 2014年 contec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol DeviceCommandDelegate <NSObject>

@required
-(void)getDeviceData:(NSDictionary *)dicDeviceData;
-(void)getOperateResult:(NSDictionary *)dicOperateResult;
-(void)getError:(NSDictionary *)dicError;

@end


@interface DeviceCommand : NSObject
@property(weak, nonatomic) id<DeviceCommandDelegate> delegate;

/*!  
 *   @method
 *
 *   @param
 *   WT01，BC401，EET,  0 receive all,1 the newest one
 *   CMS50D
 *   PM10,   －1,0,>0
 */
-(void)peripheral:(CBPeripheral *)peripheral receiveData:(NSInteger)nParam;

-(void)peripheral:(CBPeripheral *)peripheral deleteData:(NSInteger)nParam;//ABPM50，CMS50D the data will be delete automatically

-(void)markData;

-(void)peripheral:(CBPeripheral *)peripheral height:(NSInteger)nHeight weight:(float)fWeight startHour:(NSInteger)nStartHour endHour:(NSInteger)nEndHour targetCalories:(NSInteger)nTargetCalories saveDay:(NSInteger)nSaveDay sensitivity:(NSInteger)nSensitivity;//only for CMS50D,set parameter

/////////////PM10 get and set parameter
-(void)getPM10Param:(CBPeripheral *)peripheral;
-(void)peripheral:(CBPeripheral *)peripheral language:(NSInteger)nLanguage filter:(NSInteger)nFilter antiAliasing:(NSInteger)nAntiAliasing measure:(NSInteger)nMeasure saveTime:(NSInteger)nSaveTime;
/////////////////////

-(void)setSoundDirPath:(NSString *)strSoundDirPath;//fetal heart，nonsupport now!

@end
