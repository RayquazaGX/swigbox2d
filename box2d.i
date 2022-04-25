// SWIG-4.0.2 binding for Box2D v2.4.1

// Notes:
//
//   Unsupported structure members:
//     b2TreeNode::parent, b2TreeNode::next - Nested union not currently supported by SWIG
//
//   Ignored functions:
//     b2Log_Default
//

%module box2d

%{
#include "b2_settings.h"
#include "b2_draw.h"
#include "b2_timer.h"

#include "b2_shape.h"
#include "b2_chain_shape.h"
#include "b2_circle_shape.h"
#include "b2_edge_shape.h"
#include "b2_polygon_shape.h"

#include "b2_broad_phase.h"
#include "b2_dynamic_tree.h"

#include "b2_body.h"
#include "b2_contact.h"
#include "b2_fixture.h"
#include "b2_time_step.h"
#include "b2_world.h"
#include "b2_world_callbacks.h"

#include "b2_joint.h"
#include "b2_distance_joint.h"
#include "b2_friction_joint.h"
#include "b2_gear_joint.h"
#include "b2_motor_joint.h"
#include "b2_mouse_joint.h"
#include "b2_prismatic_joint.h"
#include "b2_pulley_joint.h"
#include "b2_revolute_joint.h"
#include "b2_weld_joint.h"
#include "b2_wheel_joint.h"
%}

%ignore b2Log_Default;
%ignore b2Body::SetUserData; // Deprecated after (but not including) version v2.4.1

#define B2_API_H
#define B2_API

%include "b2_settings.h"
%include "b2_draw.h"
%include "b2_timer.h"

%include "b2_shape.h"
%include "b2_chain_shape.h"
%include "b2_circle_shape.h"
%include "b2_edge_shape.h"
%include "b2_polygon_shape.h"

%include "b2_broad_phase.h"
%include "b2_dynamic_tree.h"

%include "b2_body.h"
%include "b2_contact.h"
%include "b2_fixture.h"
%include "b2_time_step.h"
%include "b2_world.h"
%include "b2_world_callbacks.h"

%include "b2_joint.h"
%include "b2_distance_joint.h"
%include "b2_friction_joint.h"
%include "b2_gear_joint.h"
%include "b2_motor_joint.h"
%include "b2_mouse_joint.h"
%include "b2_prismatic_joint.h"
%include "b2_pulley_joint.h"
%include "b2_revolute_joint.h"
%include "b2_weld_joint.h"
%include "b2_wheel_joint.h"
