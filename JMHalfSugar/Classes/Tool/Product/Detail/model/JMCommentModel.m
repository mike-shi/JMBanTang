

#import "JMCommentModel.h"
#import "JMAuthor.h"
@implementation JMCommentModel
+ (instancetype)commentWithDictionary:(NSDictionary *)dict
{
    JMCommentModel *model = [[JMCommentModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(NSDictionary *)replacedKeyFromPropertyName{

    return @{
             @"createTime":@"datestr",
             @"headerImageURL":@"avatar",
             @"content":@"conent"
             
             };

}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    NSLog(@"undefined key: %@",key);
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    if ([key isEqualToString:@"username"]) {
        _nickname = value;
    }
    if ([key isEqualToString:@"avatar"]) {
        _headerImageURL = value;
    }
    
    if ([key isEqualToString:@"datestr"]) {
        _createTime = value;
    }
    if ([key isEqualToString:@"praise"]) {
        _praiseCount = value;
    }
    if ([key isEqualToString:@"at_user"]) {
        NSDictionary *userDict = value;
        if (userDict.count != 0) {
            _isReplyed = YES;
        }
        _at_User = [JMAuthor authorWithDictionary:userDict];
    }
    if ([key isEqualToString:@"conent"]) {
        _content = value;
    }
}
@end
