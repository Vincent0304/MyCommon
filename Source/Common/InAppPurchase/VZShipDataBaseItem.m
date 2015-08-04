//
//  VZShipItem.m
//  Pirate
//
//  Created by VincentZhang on 15/7/19.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZShipDataBaseItem.h"

NSString * const kVZShipAbilityIdentifier_Capacity  = @"pirate.ship_ability_capacity";
NSString * const kVZShipAbilityIdentifier_MoreCard  = @"pirate.ship_ability_more_card";
NSString * const kVZShipAbilityIdentifier_MoreSoul  = @"pirate.ship_ability_more_soul";
NSString * const kVZShipAbilityIdentifier_MoreJoker = @"pirate.ship_ability_more_joker";

@implementation VZShipAbilityData

+(NSString *)shipAbilityImageNameWithIdentifer:(NSString *)identifer
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Image/Shipyard/Joker.png"          forKey:kVZShipAbilityIdentifier_MoreJoker];
    [dic setObject:@"Image/Shipyard/MoreSoul.png"       forKey:kVZShipAbilityIdentifier_MoreSoul];
    [dic setObject:@"Image/Shipyard/Capacity.png"       forKey:kVZShipAbilityIdentifier_Capacity];
    [dic setObject:@"Image/Shipyard/MoreCard.png"       forKey:kVZShipAbilityIdentifier_MoreCard];
    NSString* frameName = [dic objectForKey:identifer];
    return frameName;
}
@end


NSString * const kVZShipIdentifier_SmallBoat            = @"pirate.small_boat";
NSString * const kVZShipIdentifier_MediumBoat           = @"pirate.medium_boat";
NSString * const kVZShipIdentifier_Interceptor          = @"pirate.interceptor";
NSString * const kVZShipIdentifier_LargeBoat            = @"pirate.large_boat";
NSString * const kVZShipIdentifier_Dreadnought          = @"pirate.dreadnought";
NSString * const kVZShipIdentifier_BlakcPearl           = @"pirate.black_pearl";
NSString * const kVZShipIdentifier_QueenAnnesRevenge    = @"pirate.queen_anne's_revenge";
NSString * const kVZShipIdentifier_FlyingDutchman       = @"pirate.flying_dutchman";
NSString * const kVZShipIdentifier_NoahsArk             = @"pirate.noah's_ark";
NSString * const kVZShipIdentifier_EastGold             = @"pirate.east_gold";
NSString * const kVZShipIdentifier_Swan                 = @"pirate.swan";
NSString * const kVZShipIdentifier_Friendship           = @"pirate.friendship";

@implementation VZShipDataBaseItem



+(VZShipDataBaseItem *)item
{
    return [[self alloc] init];
}

+(NSString *)shipImageNameWithIdentifer:(NSString *)identifer
{
    NSString* string = @"no name";
    if([identifer isEqualToString:kVZShipIdentifier_SmallBoat])
    {
        string = @"Image/Shipyard/SmallBoat.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_MediumBoat])
    {
        string = @"Image/Shipyard/MediumBoat.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Interceptor])
    {
        string = @"Image/Shipyard/Interceptor.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_LargeBoat])
    {
        string = @"Image/Shipyard/LargeBoat.png" ;
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Dreadnought])
    {
        string = @"Image/Shipyard/Dreadnought.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_BlakcPearl])
    {
        string = @"Image/Shipyard/BlackPearl.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_QueenAnnesRevenge])
    {
        string = @"Image/Shipyard/QueenAnne'sRevenge.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_FlyingDutchman])
    {
        string = @"Image/Shipyard/FlyingDutchman.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_NoahsArk])
    {
        string = @"Image/Shipyard/Noah'sArk.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_EastGold])
    {
        string = @"Image/Shipyard/EastGold.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Swan])
    {
        string = @"Image/Shipyard/Swan.png";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Friendship])
    {
        string = @"Image/Shipyard/Friendship.png";
    }
    else
    {
        
    }
    return string;
}

+(NSString*)shipNameWithIdentifer:(NSString*)identifer
{
    NSString* string = @"no name";
    if([identifer isEqualToString:kVZShipIdentifier_SmallBoat])
    {
        string = @"Small Sailing Boat";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_MediumBoat])
    {
        string = @"Medium Sailing Boat";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Interceptor])
    {
        string = @"Interceptor";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_LargeBoat])
    {
        string = @"Large Sailing Boat";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Dreadnought])
    {
        string = @"Dreadnought";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_BlakcPearl])
    {
        string = @"Black Pearl";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_QueenAnnesRevenge])
    {
        string = @"Queen Anne's Revenge";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_FlyingDutchman])
    {
        string = @"Flying Dutchman";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_NoahsArk])
    {
        string = @"Noah's Ark";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_EastGold])
    {
        string = @"东方黄金号";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Swan])
    {
        string = @"天鹅号";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Friendship])
    {
        string = @"朋友号";
    }
    else
    {
        
    }
    return string;
}
+(NSString*)shipDetailWithIdentifer:(NSString*)identifer
{
    NSString* string = @"no detail";
    if([identifer isEqualToString:kVZShipIdentifier_SmallBoat])
    {
        string = @"The ordinary and small merchant sailing boat,there is no characteristic.";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_MediumBoat])
    {
        string = @"The ordinary and medium merchant sailing boat,which have a pretty good ability of sailing.";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Interceptor])
    {
        string = @"This is a fast and cuspidal sailing ship, which refitted from real Lady Washington. The ship so old that already can't move. The ship belong to Royal Navy and the captain is Norrington. Knightley said that Interceptor is the ship made by matchsticks, even if the slightest ripple on the water, and it also will get the shaking.";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_LargeBoat])
    {
        string = @"The large merchant sailing boat, which have a pretty good ability of sailing and warehouse also has increased.";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Dreadnought])
    {
        string = @"Dreadnought is the proud of Royal Navy.It was built based on Royal Navy winning warships “Victory” of the year. The well-known admiral Horatio Nelson was killed in Victory when defeated the French and Spanish fleets in the Battle of Trafalgar in 1805. Today,a lot of caps of the world navy that have two black belt in the back we have seen. It is a tradition that Navy around the world mourned him after he died.";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_BlakcPearl])
    {
        string = @"Originally, Black Pearl is a trade ship of East India Company. It became a pirate ship when the captain be expelled by East India Company, and became the legendary ship in the Caribbean finally.It is one of the fastest sailing ships ,which used to be occupied by a group of undead and cursed pirates.";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_QueenAnnesRevenge])
    {
        string = @"This is a 300 tons frigate which formerly called Concorde and built in England in 1710.A year later she was captured by the French. The ship could load more goods and slaves after had been restructured.At the same time,it was renamed Nantes Concorde.As a slaveship during voyage,which be grabbed by pirate captain Benjamin horney in the island of Martinique on November 28, 1718.Horney gave it to his heeler--Edward Teach,namely Blackbeard and appointed him as captain.\nBlackbeard regarded Concorde as flagship,and increase the number of artillery. Meanwhile it was renamed to Queen Anne's Revenge.This name may be related to the war of the Spanish succession,it called the Queen Anne's war in America.Blackbeard served in the royal navy at that time, perhaps sympathized to the last of the Stuart monarchs, queen Anne.Blackbeard drove the ship constantly to attacked merchant ships of Britain,Holland and Portugal from  West Africa to the Caribbean.\nAfter the blockade of Charleston Harbor in May,1718.Blackbeard refused to accept the pardoned permission of Governor, and then drove Queen Anne's Revenge into the Beaufort bay.He dismissed the fleet,carrying supplies to shifted to a boat called Adventure.He and a few sailors have been trapped in a small island nearby,and later they were rescued by Captain Sturt Bonnet.Some people think that Blackbeard stranded the boat deliberately,in order to found a excuse to dismissed sailors.\nBefore long, Blackbeard laid down his arms,to accpected to the South Carolina Governor Charles Eden in Bath.However, he returned to the pirate life eventually, and was killed in battle. ";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_FlyingDutchman])
    {
        string = @"It is a unsinkable ghost ship which can through ghostdom and the world.Truly,it is a ghost ship whose name came from Dutch of captain Davy Jones.Flying Dutchman was built in the waters around the Bahamian archipelago.Although there are full of manual exquisite carving in the ship,it is trumpery and just only a container that can float on the surface.Especially,the dirty and old deck where have a lot of Marine crustaceans,rusty cannon and mildew everywhere......just like had sank into the sea for hundreds of years and almost be incorporated into the sea.";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_NoahsArk])
    {
        string = @"It is the ship which according to God's instructions to bulit up.It is said that the ship's shape is square, while it also was portrayed as the approximate boat by many image painting.Building the ship in order that Noah and his family, as well as kinds of terrestrial creatures in the world could avoided the flood disaster of made by God.";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_EastGold])
    {
        string = @"一艘来自东方的船只，船首像是一个龙头，据说这艘船刚来到欧洲的时候，船上装满了黄金，故而被命名成黄金号";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Swan])
    {
        string = @"天鹅一般代表稀有、高贵、优雅，所以这艘船的船长将它命名成为天鹅号。听说，曾经的船长是一个女人。";
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Friendship])
    {
        string = @"这艘船的标志是一个很奇怪的字母F，曾经的船长说F的意思是Friend，所以命名成朋友号。";
    }
    else
    {
        
    }
    return string;
    
}
+(NSString*)shipImageWithIdentifer:(NSString*)identifer
{
    NSMutableDictionary* dicFrameName = [NSMutableDictionary dictionary];
    [dicFrameName setObject:@"Image/Shipyard/SmallBoat.png"          forKey:kVZShipIdentifier_SmallBoat];
    [dicFrameName setObject:@"Image/Shipyard/MediumBoat.png"         forKey:kVZShipIdentifier_MediumBoat];
    [dicFrameName setObject:@"Image/Shipyard/Interceptor.png"        forKey:kVZShipIdentifier_Interceptor];
    [dicFrameName setObject:@"Image/Shipyard/LargeBoat.png"          forKey:kVZShipIdentifier_LargeBoat];
    [dicFrameName setObject:@"Image/Shipyard/Dreadnought.png"        forKey:kVZShipIdentifier_Dreadnought];
    [dicFrameName setObject:@"Image/Shipyard/BlackPearl.png"         forKey:kVZShipIdentifier_BlakcPearl];
    [dicFrameName setObject:@"Image/Shipyard/QueenAnne'sRevenge.png" forKey:kVZShipIdentifier_QueenAnnesRevenge];
    [dicFrameName setObject:@"Image/Shipyard/FlyingDutchman.png"     forKey:kVZShipIdentifier_FlyingDutchman];
    [dicFrameName setObject:@"Image/Shipyard/Noah'sArk.png"          forKey:kVZShipIdentifier_NoahsArk];
    [dicFrameName setObject:@"Image/Shipyard/EastGold.png"           forKey:kVZShipIdentifier_EastGold];
    [dicFrameName setObject:@"Image/Shipyard/Swan.png"               forKey:kVZShipIdentifier_Swan];
    [dicFrameName setObject:@"Image/Shipyard/Friendship.png"         forKey:kVZShipIdentifier_Friendship];
    NSString* frameName = [dicFrameName objectForKey:identifer];
    return frameName;
}
+(NSArray*)shipAbilityWithIdentifer:(NSString*)identifer
{
    NSMutableArray* array = [NSMutableArray array];
    
    if([identifer isEqualToString:kVZShipIdentifier_SmallBoat])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 1;
        
        [array addObject:data1];
        
    }
    else if([identifer isEqualToString:kVZShipIdentifier_MediumBoat])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 2;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreSoul;
        data2.level = 1;
        
        [array addObject:data1];
        [array addObject:data2];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Interceptor])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 2;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreCard;
        data2.level = 1;
        
        [array addObject:data1];
        [array addObject:data2];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_LargeBoat])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 2;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreSoul;
        data2.level = 1;
        
        VZShipAbilityData* data3 = [VZShipAbilityData alloc];
        data3.identifer = kVZShipAbilityIdentifier_MoreCard;
        data3.level = 1;
        
        [array addObject:data1];
        [array addObject:data2];
        [array addObject:data3];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Dreadnought])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 2;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreSoul;
        data2.level = 1;
        
        VZShipAbilityData* data3 = [VZShipAbilityData alloc];
        data3.identifer = kVZShipAbilityIdentifier_MoreJoker;
        data3.level = 1;
        
        [array addObject:data1];
        [array addObject:data2];
        [array addObject:data3];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_BlakcPearl])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 1;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreSoul;
        data2.level = 2;
        
        VZShipAbilityData* data3 = [VZShipAbilityData alloc];
        data3.identifer = kVZShipAbilityIdentifier_MoreCard;
        data3.level = 6;
        
        VZShipAbilityData* data4 = [VZShipAbilityData alloc];
        data4.identifer = kVZShipAbilityIdentifier_MoreJoker;
        data4.level = 2;
        
        [array addObject:data1];
        [array addObject:data2];
        [array addObject:data3];
        [array addObject:data4];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_QueenAnnesRevenge])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 3;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreSoul;
        data2.level = 1;
        
        VZShipAbilityData* data3 = [VZShipAbilityData alloc];
        data3.identifer = kVZShipAbilityIdentifier_MoreCard;
        data3.level = 3;
        
        [array addObject:data1];
        [array addObject:data2];
        [array addObject:data3];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_FlyingDutchman])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 2;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreSoul;
        data2.level = 3;
        
        VZShipAbilityData* data3 = [VZShipAbilityData alloc];
        data3.identifer = kVZShipAbilityIdentifier_MoreCard;
        data3.level = 3;
        
        VZShipAbilityData* data4 = [VZShipAbilityData alloc];
        data4.identifer = kVZShipAbilityIdentifier_MoreJoker;
        data4.level = 3;
        
        [array addObject:data1];
        [array addObject:data2];
        [array addObject:data3];
        [array addObject:data4];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_NoahsArk])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 3;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreSoul;
        data2.level = 3;
        
        VZShipAbilityData* data3 = [VZShipAbilityData alloc];
        data3.identifer = kVZShipAbilityIdentifier_MoreCard;
        data3.level = 3;
        
        VZShipAbilityData* data4 = [VZShipAbilityData alloc];
        data4.identifer = kVZShipAbilityIdentifier_MoreJoker;
        data4.level = 3;
        
        [array addObject:data1];
        [array addObject:data2];
        [array addObject:data3];
        [array addObject:data4];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_EastGold])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 2;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreSoul;
        data2.level = 5;
        
        VZShipAbilityData* data3 = [VZShipAbilityData alloc];
        data3.identifer = kVZShipAbilityIdentifier_MoreCard;
        data3.level = 2;
        
        [array addObject:data1];
        [array addObject:data2];
        [array addObject:data3];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Swan])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 3;
        
        VZShipAbilityData* data2 = [VZShipAbilityData alloc];
        data2.identifer = kVZShipAbilityIdentifier_MoreCard;
        data2.level = 5;
        
        [array addObject:data1];
        [array addObject:data2];
    }
    else if([identifer isEqualToString:kVZShipIdentifier_Friendship])
    {
        VZShipAbilityData* data1 = [VZShipAbilityData alloc];
        data1.identifer = kVZShipAbilityIdentifier_Capacity;
        data1.level = 2;
        
        VZShipAbilityData* data3 = [VZShipAbilityData alloc];
        data3.identifer = kVZShipAbilityIdentifier_MoreCard;
        data3.level = 4;
        
        VZShipAbilityData* data4 = [VZShipAbilityData alloc];
        data4.identifer = kVZShipAbilityIdentifier_MoreJoker;
        data4.level = 4;
        
        [array addObject:data1];
        [array addObject:data3];
        [array addObject:data4];
    }
    else
    {
        
    }
    return array;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.state forKey:@"state"];
    [aCoder encodeFloat:self.price forKey:@"price"];

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.state = [aDecoder decodeIntForKey:@"state"];
        self.price = [aDecoder decodeFloatForKey:@"price"];
    }
    return self;
}

-(id)init
{
    if(self = [super init])
    {
        self.state = 0;
        self.price = 0;
    }
    return self;
}

@end
