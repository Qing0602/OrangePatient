/*
 * // Example
 *
 * #import "pinyin.h"
 *
 * NSString *hanyu = @"中国共产党万岁！";
 * for (int i = 0; i < [hanyu length]; i++)
 * {
 *     printf("%c", pinyinFirstLetter([hanyu characterAtIndex:i]));
 * }
 *
 */
#define HANZI_START 19968
#define HANZI_COUNT 20902

#define ALPHA	@"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
char pinyinFirstLetter(unsigned short hanzi);