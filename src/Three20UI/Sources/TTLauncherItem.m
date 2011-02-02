//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "Three20UI/TTLauncherItem.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTLauncherItem

@synthesize launcher    = _launcher;
@synthesize title       = _title;
@synthesize imageURL    = _imageURL;
@synthesize URL         = _URL;
@synthesize style       = _style;
@synthesize badgeNumber = _badgeNumber;
@synthesize canDelete   = _canDelete;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTitle:(NSString*)title imageURL:(NSString*)imageURL URL:(NSString*)URL {
  if (self = [self initWithTitle:title imageURL:imageURL URL:URL canDelete:NO]) {
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTitle:(NSString*)title imageURL:(NSString*)imageURL URL:(NSString*)URL
      canDelete:(BOOL)canDelete {
  if (self = [super init]) {
    _canDelete = canDelete;

    self.title = title;
    self.imageURL = imageURL;
    self.URL = URL;
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_title);
  TT_RELEASE_SAFELY(_imageURL);
  TT_RELEASE_SAFELY(_URL);
  TT_RELEASE_SAFELY(_style);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super init]) {
    self.title = [decoder decodeObjectForKey:@"title"];
	if ([decoder containsValueForKey:@"image"]) //backword compatible coder
	{
		self.imageURL = [decoder decodeObjectForKey:@"image"];
	}
	else
	{
		self.imageURL = [decoder decodeObjectForKey:@"imageURL"];
	}
    self.URL = [decoder decodeObjectForKey:@"URL"];
    self.style = [decoder decodeObjectForKey:@"style"];
    self.canDelete = [decoder decodeBoolForKey:@"canDelete"];
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
  [encoder encodeObject:_title forKey:@"title"];
  [encoder encodeObject:_imageURL forKey:@"imageURL"];
  [encoder encodeObject:_URL forKey:@"URL"];
  [encoder encodeObject:_style forKey:@"style"];
  [encoder encodeBool:_canDelete forKey:@"canDelete"];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBadgeNumber:(NSInteger)badgeNumber {
  _badgeNumber = badgeNumber;

  [_launcher performSelector:@selector(updateItemBadge:) withObject:self];
}


@end
