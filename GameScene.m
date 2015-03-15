//
//  GameScene.m
//  Sprites and Forces
//
//  Created by Robert Zimmelman on 12/23/14.
//  Copyright (c) 2014 Robert Zimmelman. All rights reserved.
//

#import "GameScene.h"
long myForce = 0;
long mySpringStrength = 10;
long myVortexStrength = 8;
//long myVortexSpringStrength = 1;




SKSpriteNode *myColorSprite;
@implementation GameScene


-(void)didMoveToView:(SKView *)view {
    [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame] ];
    NSArray *myTopControlValues  = @[@"Colors",@"Sprite",@"Pics", @"Forces" , @"Hide Forces", @"Quit"] ;
    UISegmentedControl *myTopControl = [[ UISegmentedControl alloc] initWithItems:myTopControlValues ];
    int myTopControlSeqmentWidth = 85;
    [myTopControl addTarget:self action:@selector(myTopSwitchChanged:) forControlEvents:UIControlEventValueChanged ];
    [myTopControl setWidth:myTopControlSeqmentWidth forSegmentAtIndex:4];
    [myTopControl setSelectedSegmentIndex:-1];
    [myTopControl setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    [self.view addSubview:myTopControl];
    NSArray *myBottomControlValues  = @[@"+",@"-",@"Vortex",@"Gravity",@"+",@"-"] ;
    UISegmentedControl *myBottomControl = [[ UISegmentedControl alloc] initWithItems:myBottomControlValues ];
    [myBottomControl setFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50)];
    [myBottomControl setApportionsSegmentWidthsByContent:NO];
    [myBottomControl addTarget:self action:@selector(myBottomSwitchChanged:) forControlEvents:UIControlEventValueChanged ];
    [myBottomControl setSelectedSegmentIndex:3];
    myForce = 3;
    [self.view addSubview:myBottomControl];
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    myLabel.text = @"Sprites and Forces!  Tap Screen to Place Force Fields";
    myLabel.fontSize = 18;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame)+200);
    [self addChild:myLabel];
    [myLabel runAction:[SKAction sequence:@[ [SKAction waitForDuration:3.0],
                                             [SKAction removeFromParent],
                                             ]]];
    
    SKSpriteNode *myHolderNode = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeZero];
    [myHolderNode setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self addChild:myHolderNode];
    NSString *myFireFliesEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"myFireFlies" ofType:@"sks"];
    SKEmitterNode *myFireFliesEmitterNode =  [NSKeyedUnarchiver unarchiveObjectWithFile:myFireFliesEmitterNodePath];
    [myHolderNode addChild:myFireFliesEmitterNode];
    [self makeMyInstructionLabels];
}


-(void)makeMyInstructionLabels{
    SKLabelNode *myLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [myLabel1 setText:@"Tap Top Buttons for Colors, Sprite, Pictures"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel1 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [myLabel1 setFontSize:16];
    [myLabel1 setFontColor:[UIColor redColor]];
    [myLabel1 setAlpha:0.0];
    [self addChild:myLabel1];
    [myLabel1 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:2.0],]]];
    
    
    
    SKLabelNode *myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel2 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-20)];
    [myLabel2 setFontSize:16];
    [myLabel2 setFontColor:[UIColor redColor]];
    [myLabel2 setText:@"Top Top Buttons to Show or Hide Forces"];
    [myLabel2 setAlpha:0.0];
    [self addChild:myLabel2];
    [myLabel2 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:3.0],]]];
    
    SKLabelNode *myLabel3 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel3 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40)];
    [myLabel3 setFontSize:16];
    [myLabel3 setFontColor:[UIColor redColor]];
    [myLabel3 setText:@"Tap Bottom Buttons for Vortex or Gravity Force"];
    [myLabel3 setAlpha:0.0];
    [self addChild:myLabel3];
    [myLabel3 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:4.0],]]];
    
    
    SKLabelNode *myLabel4 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel4 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-60)];
    [myLabel4 setFontSize:16];
    [myLabel4 setFontColor:[UIColor redColor]];
    [myLabel4 setText:@"Tap + or - to Increase or Decrease Force"];
    [myLabel4 setAlpha:0.0];
    [self addChild:myLabel4];
    [myLabel4 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:5.0],]]];
    
}



- (IBAction)myTopSwitchChanged:(UISegmentedControl *)sender{
    long myValue = sender.selectedSegmentIndex;
    if (myValue == 0) {
        NSInteger myNumberOfLoops = 5;
        NSInteger myColorSpriteSize = 15;
        //        SKSpriteNode *myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor darkGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
        for ( int i = 1 ; i < myNumberOfLoops ; i++){
            for (int mySpriteCounter = 1; mySpriteCounter <= 13; mySpriteCounter++) {
                switch (mySpriteCounter) {
                    case 1:
                        myColorSprite =  [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 2:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor darkGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 3:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 4:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 5:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 6:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 7:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 8:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor cyanColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 9:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 10:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor magentaColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 11:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 12:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor purpleColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    case 13:
                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor brownColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                        break;
                    default:
                        break;
                }  // end of switch
                myColorSprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                                     CGRectGetMaxY(self.frame)-30);
                myColorSprite.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize:myColorSprite.size];
                myColorSprite.physicsBody.mass = 1;
                myColorSprite.physicsBody.restitution = .9;
                myColorSprite.physicsBody.affectedByGravity = YES;
                myColorSprite.physicsBody.linearDamping = 3.0;
                myColorSprite.blendMode = SKBlendModeReplace ;
                myColorSprite.physicsBody.contactTestBitMask = 0x03;
                [self addChild:myColorSprite];
                SKAction *mycolorSpriteAction =    [SKAction sequence:@[
                                                                        [SKAction waitForDuration:30.0 withRange:1.5],
                                                                        [SKAction removeFromParent],
                                                                        ]];
                [myColorSprite runAction:mycolorSpriteAction];
            }  // end of mySpriteCounter Loop
        }  // end of myNUmberOfLoops Loop
        [sender setSelectedSegmentIndex:-1];
        
    } // end of if myValue == 0
    
    else if (myValue == 1) {
        SKSpriteNode *colorsprite = [SKSpriteNode spriteNodeWithImageNamed:@"Julius Zimmelman.jpg"];
        colorsprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                           CGRectGetMaxY(self.frame)-1);
        [colorsprite setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:colorsprite.size]];
        [colorsprite.physicsBody setAffectedByGravity:YES];
        [colorsprite setScale:.6];
        colorsprite.physicsBody.mass = 1;
        colorsprite.physicsBody.linearDamping = 5;
        colorsprite.zPosition = 1;
        SKAction *mycolorSpriteAction =    [SKAction sequence:@[
                                                                [SKAction waitForDuration:10.0 withRange:0.5],
                                                                [SKAction removeFromParent],
                                                                ]];
        [colorsprite runAction:mycolorSpriteAction];
        
        [self addChild:colorsprite];
        [sender setSelectedSegmentIndex:-1];
    }
    
    
    else if (myValue == 2) {
        
        NSString *mySpriteName = @"";
        NSArray *mySprites  = @[@"Danny",  @"Mike", @"Andy", @"Cindy" , @"Dad"] ;
        //
        //
        // rz set the number of sprites to the size of the mySprites array
        
        NSInteger myNumberofSprites = [mySprites count];
        int myLoops = 1;
        float myScale = 0.1;
        //
        //
        
        CGPoint location = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMaxY(self.frame)-30);
        for (int myLoopCounter = 0 ; myLoopCounter < myLoops ; myLoopCounter++) {
            for (int myCount = 0; myCount < myNumberofSprites ; myCount++) {
                mySpriteName = mySprites[myCount];
                SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:mySpriteName];
                sprite.position = location;
                //
                //  rz physicsbody stuff here
                //
                sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
                sprite.physicsBody.linearDamping = 5;
                sprite.physicsBody.mass = 1;
                sprite.zPosition = 1;
                sprite.xScale = sprite.yScale = myScale;
                [sprite runAction:
                 [SKAction sequence:@[
                                      [SKAction waitForDuration:10 withRange:1.5],
                                      [SKAction removeFromParent],
                                      ]]  ];
                [self addChild:sprite];
                //[sprite addChild:myExitEmitter];
            }
        } // end of loopcount loop
        
        [sender setSelectedSegmentIndex:-1];
    }
    else if (myValue == 3) {
        //
        // show forces
        [self.view setShowsFields:YES];
        [sender setSelectedSegmentIndex:-1];
    }
    
    else if (myValue == 4) {
        [self.view setShowsFields:NO];
        [sender setSelectedSegmentIndex:-1];
    }
    else if (myValue == 5){
        exit(0);
    }
    
}






-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        SKAction *myEffectSpriteAction = [SKAction sequence:@[
                                                              [SKAction waitForDuration:10.0 withRange:5.5],
                                                              [SKAction removeFromParent],
                                                              ]];
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *myPositionSprite = [[SKSpriteNode alloc] initWithColor:[UIColor blackColor] size:CGSizeMake(10, 10)];
        [myPositionSprite setPosition:location];
        NSString *mySpringEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
        SKEmitterNode *myEmitterNode =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
        SKEmitterNode *mySpringNodeEmitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
        SKFieldNode *mySpringFieldNode = [SKFieldNode springField];
        SKSpriteNode *myForceImage = [SKSpriteNode spriteNodeWithImageNamed:@"rzForces Image.png"];
        [myForceImage setAlpha:.3];
        [myForceImage setScale:.2];
        SKAction *mySlowSpin = [SKAction rotateByAngle:M_PI*50 duration:30];
        SKAction *mySpringNodeFade = [SKAction sequence:@[
                                                          [SKAction fadeInWithDuration:(NSTimeInterval) 0.25],
                                                          [SKAction fadeOutWithDuration:(NSTimeInterval) 0.55],
                                                          ]];
        [mySpringNodeEmitter setScale:1.5];
        [mySpringNodeEmitter runAction:[SKAction repeatAction:mySpringNodeFade count:10]];
        //        NSLog(@"NOW myforce = %ld",myForce);
        switch (myForce) {
            case 2:
            {
                NSString *myVortexEmitterPath = [[NSBundle mainBundle] pathForResource:@"VortexParticle" ofType:@"sks"] ;
//                SKPhysicsBody *myVortexEmitterPhysicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
                SKEmitterNode *myVortexEmitterNode = [NSKeyedUnarchiver unarchiveObjectWithFile:myVortexEmitterPath];
                SKFieldNode *myVortexFieldNode = [SKFieldNode vortexField];
                [myVortexFieldNode setDirection:1.0];
                [myVortexFieldNode setStrength: myVortexStrength ];
                [myVortexFieldNode setFalloff: 1 ];
                [myVortexFieldNode setName:@"vortex"];
//                [myVortexEmitterNode setPhysicsBody:myVortexEmitterPhysicsBody];
//                [myVortexEmitterNode.physicsBody setLinearDamping:3];
                [myPositionSprite runAction:myEffectSpriteAction];
                [myPositionSprite addChild:myForceImage];
                [myPositionSprite addChild:myEmitterNode];
                [myPositionSprite addChild:myVortexFieldNode];
                [myPositionSprite addChild:myVortexEmitterNode];
                [mySpringFieldNode setStrength: mySpringStrength ];
                [myPositionSprite addChild:mySpringFieldNode];
                [self addChild:myPositionSprite];
                [myPositionSprite runAction:mySlowSpin];
                break;
            }
            case 3:
            {
                [mySpringFieldNode setStrength: mySpringStrength ];
                [mySpringFieldNode setName:@"spring"];
                [myPositionSprite setPosition:location];
                [myPositionSprite runAction:myEffectSpriteAction];
                [myPositionSprite addChild:mySpringNodeEmitter];
                [myPositionSprite addChild:mySpringFieldNode];
                [self addChild:myPositionSprite];
            }
            default:
                break;
        }
        
    }
}

- (IBAction)myBottomSwitchChanged:(UISegmentedControl *)sender{
    long myValue = sender.selectedSegmentIndex;
    //    NSLog(@"Value = %ld",myValue);
    switch (myValue) {
        case 0:
            myVortexStrength-=2;
            [sender setSelectedSegmentIndex:myForce];
            break;
        case 1:
            myVortexStrength+=2;
            [sender setSelectedSegmentIndex:myForce];
            break;
        case 2:
            myForce = myValue;
            [sender setSelectedSegmentIndex:myForce];
            break;
        case 3:
            myForce = myValue;
            [sender setSelectedSegmentIndex:myForce];
            break;
        case 4:
            mySpringStrength-=10;
            [sender setSelectedSegmentIndex:myForce];
            break;
        default:
            mySpringStrength+=10;
            [sender setSelectedSegmentIndex:myForce];
            break;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
//    [self enumerateChildNodesWithName:@"vortex" usingBlock:^(SKFieldNode *node, BOOL *stop) {
//        [node setStrength:myVortexStrength ];
//    }];
//    [self enumerateChildNodesWithName:@"spring" usingBlock:^(SKFieldNode *node, BOOL *stop) {
//        [node setStrength:mySpringStrength ];
//    }];
}

@end
