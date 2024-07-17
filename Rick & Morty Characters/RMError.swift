import Foundation

enum RMError: String, Error {
    case invalidPage = "This page created an invalid requset. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponce = "Invalid responce from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
