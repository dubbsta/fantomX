Strict
#rem
'/*
'* Copyright (c) 2011, Damian Sinclair
'*
'* This is a port of Box2D by Erin Catto (box2d.org).
'* It is translated from the Flash port: Box2DFlash, by BorisTheBrave (http://www.box2dflash.org/).
'* Box2DFlash also credits Matt Bush and John Nesky as contributors.
'*
'* All rights reserved.
'* Redistribution and use in source and binary forms, with or without
'* modification, are permitted provided that the following conditions are met:
'*
'*   - Redistributions of source code must retain the above copyright
'*     notice, this list of conditions and the following disclaimer.
'*   - Redistributions in binary form must reproduce the above copyright
'*     notice, this list of conditions and the following disclaimer in the
'*     documentation and/or other materials provided with the distribution.
'*
'* THIS SOFTWARE IS PROVIDED BY THE MONKEYBOX2D PROJECT CONTRIBUTORS "AS IS" AND
'* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
'* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
'* DISCLAIMED. IN NO EVENT SHALL THE MONKEYBOX2D PROJECT CONTRIBUTORS BE LIABLE
'* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
'* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
'* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
'* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
'* LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
'* OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
'* DAMAGE.
'*/
#end

Import fantomX

#rem
'/**
'* Weld joint definition. You need to specify local anchor points
'* where they are attached and the relative body angle. The position
'Import of
'* @see b2WeldJoint
'*/
#end
Class b2WeldJointDef Extends b2JointDef
    
    Method New()
        Super.New()
        type = b2Joint.e_weldJoint
        referenceAngle = 0.0
    End
    #rem
    '/**
    '* Initialize the bodies, anchors, axis, and reference angle using the world
    '* anchor and world axis.
    '*/
    #end
    Method Initialize : void (bA:b2Body, bB:b2Body,
        anchor:b2Vec2)
        
        bodyA = bA
        bodyB = bB
        bodyA.GetLocalPoint(anchor,localAnchorA)
        bodyB.GetLocalPoint(anchor,localAnchorB)
        referenceAngle = bodyB.GetAngle() - bodyA.GetAngle()
    End
    #rem
    '/**
    '* The local anchor point relative to bodyAs origin.
    '*/
    #end
    Field localAnchorA:b2Vec2 = New b2Vec2()
    
    #rem
    '/**
    '* The local anchor point relative to bodyBs origin.
    '*/
    #end
    Field localAnchorB:b2Vec2 = New b2Vec2()
    
    #rem
    '/**
    '* The body2 angle minus body1 angle in the reference state (radians).
    '*/
    #end
    Field referenceAngle:Float
    
    
End

