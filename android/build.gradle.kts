
buildscript {
    repositories {
        google() // ✅ Google Maven repo
        mavenCentral() // ✅ Maven Central repo
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.3.0") // ✅ Or your version
        classpath("com.google.gms:google-services:4.4.1") // ✅ This is needed for Firebase
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
