//
//  Post.swift
//  Cresh
//
//  Created by Subomi Popoola on 10/1/20.
//  Copyright © 2020 Subomi Popoola. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    
    @NSManaged var media : PFFileObject
    @NSManaged var author: PFUser
    @NSManaged var groupName: String
    @NSManaged var caption: String
    @NSManaged var members: [String]
    
    class func parseClassName() -> String {
        return "Post"
    }
    
    class func createGroup(image: UIImage?, withName groupName: String?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = Post()
        
        // Add relevant fields to the object
        post.media = getPFFileFromImage(image: image)! // PFFile column type
        post.author = PFUser.current()! // Pointer column type that points to PFUser
        post.groupName = groupName!
        post.caption = (caption == "" ? "- No Description" : caption)!
        post.members = [String]()
        post.members.append((PFUser.current()?.username)!)
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground()
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFileObject? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = image.pngData() {
                  return PFFileObject(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
