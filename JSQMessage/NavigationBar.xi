<?xml version="1.0" encoding="UTF-8"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="14460.31" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    <device id="retina4_7" orientation="portrait">
        <adaptation id="fullscreen"/>
    </device>
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="14460.20"/>
        <capability name="Safe area layout guides" minToolsVersion="9.0"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner" customClass="NavigationBar" customModule="JSQMessage" customModuleProvider="target"/>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
        <view contentMode="scaleToFill" id="iN0-l3-epB">
            <rect key="frame" x="0.0" y="0.0" width="375" height="667"/>
            <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
            <subviews>
                <navigationBar contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="pZG-Um-xUt">
                    <rect key="frame" x="0.0" y="20" width="375" height="44"/>
                    <autoresizingMask key="autoresizingMask" widthSizable="YES" flexibleMaxY="YES"/>
                    <color key="barTintColor" red="0.66666668650000005" green="0.63441297819999998" blue="0.37072952570000001" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
                    <items>
                        <navigationItem title="Title" id="p9r-Al-AqH">
                            <barButtonItem key="leftBarButtonItem" title="Item" id="Tnf-nC-Cpe"/>
                        </navigationItem>
                    </items>
                </navigationBar>
            </subviews>
            <color key="backgroundColor" red="1" green="1" blue="1" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
            <viewLayoutGuide key="safeArea" id="vUN-kp-3ea"/>
            <point key="canvasLocation" x="25" y="72"/>
        </view>
    </objects>
</document>
