//
//  ViewController.m
//  BlueTooth
//
//  Created by cssmk_jzb on 16/2/16.
//  Copyright © 2016年 cssmk_jzb. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate>
{
    CBCentralManager *manager;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.textView.editable = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)scan
{
    NSLog(@"manager.state %ld",manager.state);
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    [manager scanForPeripheralsWithServices:nil options:options];
}



- (IBAction)stopScanning
{
    [manager stopScan];
}

- (void)connect:(CBPeripheral *)peripheral
{
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey];
    [manager connectPeripheral:peripheral options:options];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            NSLog(@"蓝牙未打开");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"蓝牙已开");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"不支持蓝牙4.0 BLE");
            break;
            
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"%@",peripheral.identifier);
    NSUUID *uuid = peripheral.identifier;
    [self.textView setText:uuid.UUIDString];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
