import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "univ.directing.ai.chat.dev"
            resValue(type = "string", name = "app_name", value = "Univ Guidance Dev")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "univ.directing.ai.chat"
            resValue(type = "string", name = "app_name", value = "Univ Guidance")
        }
    }
}