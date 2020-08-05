//
//  main.m
//  ClearKC
//
//  Created by wangyankun on 2020/8/5.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

int main (int argc, const char * argv[])
{

    @autoreleasepool
    {	
    	// insert code here...
    	NSLog(@"Hello, World!");
        
        sqlite3 *database;
        int openDBFile = sqlite3_open("/var/Keychains/keychain-2.db", &database);
        if (openDBFile == SQLITE_OK) {
            //删除genp表
            char *errmsg;
            const char* sql = "DELETE FROM genp WHERE agrp<>'apple'";
            int executeResult = sqlite3_exec(database, sql, NULL, NULL, &errmsg);
            if (errmsg) {
                NSLog(@"errmsg : %s",errmsg);
                exit(0);
            }
            if (executeResult != SQLITE_OK) NSLog(@"iOSRE: Failed to exec DELETE FROM genp WHERE agrp<>'apple', error %d", executeResult);
            
            //删除cert表
            executeResult = sqlite3_exec(database, "DELETE FROM cert WHERE agrp<>'lockdown-identities'", NULL, NULL, &errmsg);
            if (errmsg) {
                NSLog(@"errmsg : %s",errmsg);
                exit(0);
            }
            if (executeResult != SQLITE_OK) NSLog(@"iOSRE: Failed to exec DELETE FROM cert WHERE agrp<>'lockdown-identities', error %d", executeResult);
            
            
            //删除keys表
            executeResult = sqlite3_exec(database, "DELETE FROM keys WHERE agrp<>'lockdown-identities'", NULL, NULL, &errmsg);
            if (errmsg) {
                NSLog(@"errmsg : %s",errmsg);
                exit(0);
            }
            if (executeResult != SQLITE_OK) NSLog(@"iOSRE: Failed to exec DELETE FROM keys WHERE agrp<>'lockdown-identities'', error %d", executeResult);
            
            //删除inet表
            executeResult = sqlite3_exec(database, "DELETE FROM inet", NULL, NULL, &errmsg);
            if (errmsg) {
                NSLog(@"errmsg : %s",errmsg);
                exit(0);
            }
            if (executeResult != SQLITE_OK) NSLog(@"iOSRE: Failed to exec DELETE FROM inet, error %d", executeResult);
            
            //删除sqlite_sequence表
            executeResult = sqlite3_exec(database, "DELETE FROM sqlite_sequence", NULL, NULL, &errmsg);
            if (errmsg) {
                NSLog(@"errmsg : %s",errmsg);
                exit(0);
            }
            if (executeResult != SQLITE_OK) NSLog(@"iOSRE: Failed to exec DELETE FROM sqlite_sequence, error %d", executeResult);
            
        }else {
            NSLog(@"打开数据库失败，错误码 ： %d",openDBFile);
        }
    }
	return 0;
}

