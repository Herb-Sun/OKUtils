/**
 * @providesModule GlobalStarRateView
 */
import React, { Component, PropTypes} from "react";
import { 
    View,
    Image,
    StyleSheet,
    PanResponder,
    Animated,
    UIManager,
    findNodeHandle,
    Platform,
 } from "react-native";

 export default class GlobalStarRateView extends Component {

    static propTypes = {        
        maxStars: PropTypes.number.isRequired,
        defaultValue: PropTypes.number,
        disabled: PropTypes.bool,
        style: View.propTypes.style,
        starSize: PropTypes.number,
        starMargin: PropTypes.number,
        rateType: PropTypes.oneOf(['Whole', 'Half', 'Incomplete']),
        normalStarImageSource: PropTypes.oneOfType([
            PropTypes.shape({
              uri: PropTypes.string,
            }),
            // Opaque type returned by require('./image.jpg')
            PropTypes.number,
        ]),
        highlightStarImageSource: PropTypes.oneOfType([
            PropTypes.shape({
              uri: PropTypes.string,
            }),
            // Opaque type returned by require('./image.jpg')
            PropTypes.number,
        ]),
        animationTimeInterval: PropTypes.number,
        onChanged: PropTypes.func,
    }

    static defaultProps = {
        maxStars: 0,
        defaultValue: 0,
        disabled: false,
        style: {},
        starSize: 30,
        starMargin: 5,
        rateType: 'Whole',
        animationTimeInterval: 0,
        onChanged: ()=>undefined,
    }

    constructor(props) {
        super(props);
        const {defaultValue} = props;
        this.state = {
            latestX: this._convertRate2X(defaultValue)
        }
    }

    render() {
        const {
            style, 
            maxStars, 
            starSize, 
            starMargin,
            disabled,
            defaultValue,
        } = this.props;

        const width = (maxStars - 1) * starMargin + maxStars * starSize;
        const containerStyle = {
            ...style,
            flexDirection:'row',
            width: width,
            height: starSize
        }
        const gestureHandlers = disabled ? {} : this._handleResponse().panHandlers;
        
        return (
            <View 
                ref={ _view => this._view = _view} 
                style={containerStyle} 
                collapsable={false}
                {...gestureHandlers}>

                <View style={styles.normalImagesStyle}>
                    {this._renderStarView(this.props.normalStarImageSource)}
                </View>

                <View style={[styles.highlightImagesStyle, { width: this.state.latestX, backgroundColor:'transparent'}]}>
                    {this._renderStarView(this.props.highlightStarImageSource)}
                </View>
            </View>
        );
    }

    _renderStarView = (imageSource) => {
        const {maxStars, starSize, starMargin} = this.props;
        const imageContrainer = [];

        for (let i = 0; i < maxStars; i++) {
            imageContrainer.push(
                <Image
                    key={i} 
                    resizeMede={'center'} 
                    style={{
                        position: 'absolute',
                        width: starSize,
                        height: starSize,
                        left: i * (starSize + starMargin),
                    }} 
                    source={imageSource}/>
            );
        }
        
        return imageContrainer;
    }

    _convertRate2X = rate => {

        const {maxStars, starMargin, starSize, rateType} = this.props;
        const unit = (starSize + starMargin);
        
        switch (rateType) {
            case 'Whole': return Math.floor(rate) * unit; break;
            case 'Half':
            case 'Incomplete':{
                return Math.floor(rate / 1.0) * unit + (rate % 1.0 > 0 ? (starSize * 0.5) : 0)
                break;
            }
            default: return 0.0; break;
        }
    }

    _handleResponse = () => {
        return PanResponder.create({
            onStartShouldSetPanResponder: (evt, gestureState) => true,
            onStartShouldSetPanResponderCapture: (evt, gestureState) => true,
            onMoveShouldSetPanResponder: (evt, gestureState) => false,
            onMoveShouldSetPanResponderCapture: (evt, gestureState) => false,
            onPanResponderTerminationRequest: (evt, gestureState) => true,
            
            onPanResponderGrant: (evt, gestureState) => {
                const eventPageX = evt.nativeEvent.pageX;
                const {maxStars, starMargin, starSize, rateType} = this.props;
                
                UIManager.measure(findNodeHandle(this._view), (x, y, width, height, pageX, pageY)=>{
                    const diffX = eventPageX - pageX;
                    const unit = (starSize + starMargin);

                    switch (rateType) {
                        case 'Whole': {
                            const quot =  Math.floor(diffX / (starSize + starMargin));
                            const remainder = diffX % (starSize + starMargin);
                            const rate = remainder > 0 ? (quot + 1) : quot;

                            this.setState({
                                latestX: this._convertRate2X(rate)
                            });
                            if (this.props.onChanged) {
                                this.props.onChanged(rate);
                            }
                            break;
                        }
                        case 'Half': {
                            const quot = Math.floor(diffX / unit);
                            const remainMargin = diffX - quot * unit;
                            const rate = (remainMargin < (starSize * 0.5)) ? quot + 0.5 : quot + 1.0;

                            this.setState({
                                latestX: this._convertRate2X(rate)
                            });
                            if (this.props.onChanged) {
                                this.props.onChanged(rate);
                            }
                            break;
                        }
                        case 'Incomplete': {
                            const quot = Math.floor(diffX / unit);
                            const remainMargin = diffX - quot * unit;
                            const rate = (remainMargin < (starSize * 0.5)) ? quot + 0.5 : quot + 1.0;
                            
                            this.setState({
                                latestX: diffX
                            });
                            if (this.props.onChanged) {
                                this.props.onChanged(rate);
                            }
                            break;
                        }
                        default:
                            break;
                    }

                });
            },
        });
    }
 }

 const styles = StyleSheet.create({
    normalImagesStyle: {
        position: 'absolute',
        overflow: 'hidden',
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
    },
    highlightImagesStyle: {
        position: 'absolute',
        overflow: 'hidden',
        left: 0,
        top: 0,
        bottom: 0, 
    },
 });