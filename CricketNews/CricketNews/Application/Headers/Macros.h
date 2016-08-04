//
//  Macros.h
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define SCREEN_MIN_LENGTH   (MIN(([[UIScreen mainScreen] bounds].size.width), ([[UIScreen mainScreen] bounds].size.height)))

#define SCREEN_MAX_LENGTH   (MAX(([[UIScreen mainScreen] bounds].size.width), ([[UIScreen mainScreen] bounds].size.height)))

// PTPX
#define PTPX(pt)         ([UIUtils pointsToPixels:pt])

//Used to print debugging output
#define PRINT_LOGS

#ifdef PRINT_LOGS
#   define DebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
#   define DebugLog(...)
#endif

#endif /* Macros_h */
