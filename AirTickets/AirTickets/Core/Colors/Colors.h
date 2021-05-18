//
//  Colors.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#ifndef Colors_h
#define Colors_h


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define orangeCrayolaColor 0xFF7733
#define orangeSodaColor 0xF85A3E

#endif /* Colors_h */