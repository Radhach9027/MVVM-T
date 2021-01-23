//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

/**
 !* @discussion: All the below cases refers to stories i.e., (.storyBoard)
*/

public enum StoryDestination: String { // Different Storyboards.
    case login = "Login"
    case tab = "TabBar"
}

/**
 !* @discussion: All the below cases refers to viewcontroller from all the stories i.e., (.storyBoard)
*/

public enum ControllerDestination: String { // Different ViewControllers.
    case login =  "LoginViewController"
    case signup = "SignupViewController"
    case launch = "LaunchViewController"
    case tab = "TabBarController"
    case home = "HomeViewController"
    case profile = "ProfileViewController"
    case detail = "HomeDetailsViewController"
    case forgotPassword = "ForgotPasswordViewController"
}

