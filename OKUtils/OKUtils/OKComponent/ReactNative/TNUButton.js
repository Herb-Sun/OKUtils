/**
 * 兼容iOS和Android的Button
 * Author sunhuabei
 * @providesModule TNUButton
 */
import React from 'react';
import {
    TouchableWithoutFeedback,
    Text,
    StyleSheet,
    View,
    ActivityIndicator
} from 'react-native';


export default class TNUButton extends React.Component {
    static defaultProps = {
        size: 'large', 
        type: 'default', 
        pressIn: false,
        disabled: false,
        loading: false,
        activeStyle: false,
        onPress: () => {},
        onLongPress: () => {},
        onPressIn: () => {},
        onPressOut: () => {},
    };

    constructor(props) {
        super(props);
        this.state = {
            pressIn: false,
            touchIt: false,
        };
    }

    onPressIn = (...arg) => {
        if (this.props.activeStyle) {
            this.setState({
                pressIn: true
            });
            if (this.props.onPressIn) {
                this.props.onPressIn(...arg);
            }
        }
    }
    onPressOut = (...arg) => {
        if (this.props.activeStyle) {
            this.setState({
                pressIn: false
            });
            if (this.props.onPressOut) {
                this.props.onPressOut(...arg);
            }
        }
    }

    render() {
        const {
          size = 'large', 
          type = 'default', 
          disabled, 
          activeStyle, 
          onPress,
          onLongPress,
          onPressIn,
          onPressOut,
          style,
          loading,
          children,
          ...otherProps,
        } = this.props;
    
        const textStyle = [
          styles[`${size}RawText`],
          styles[`${type}RawText`],
          disabled && styles[`${type}DisabledRawText`],
          this.state.pressIn && styles[`${type}HighlightText`],
        ];
    
        const wrapperStyle = [
          styles.wrapperStyle,
          styles[`${size}Raw`],
          styles[`${type}Raw`],
          disabled && styles[`${type}DisabledRaw`],
          this.state.pressIn && activeStyle && styles[`${type}Highlight`],
          activeStyle && this.state.touchIt && activeStyle,
          style,
        ];
    
        const indicatorStyle = this.state.pressIn ? styles[`${type}HighlightText`] : styles[`${type}RawText`];
        const indicatorColor = StyleSheet.flatten(indicatorStyle)['color'];
    
        const childrenDom = React.isValidElement(children) ? (
            this.props.children
        ) : (
            <Text style={StyleSheet.flatten(textStyle)}>{this.props.children}</Text>
        );


        return (
          <TouchableWithoutFeedback
            onPress={() => onPress && onPress()}
            onLongPress={() => onLongPress && onLongPress()}
            onPressIn={this.onPressIn}
            onPressOut={this.onPressOut}
            disabled={disabled}
            {...otherProps}
          >
          <View style={StyleSheet.flatten(wrapperStyle)}>
            <View style={styles.container}>
              {
                loading ? (
                  <ActivityIndicator
                    style={styles.indicator}
                    animating
                    color={indicatorColor}
                    size="small"
                  />
                ) : null
              }
              {childrenDom}
            </View>
            </View>
          </TouchableWithoutFeedback>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
    },
    defaultHighlight: {
        backgroundColor: '#dddddd',
        borderColor: '#dddddd',
    },
    primaryHighlight: {
        backgroundColor: '#0e80d2',
        borderColor: '#108ee9',
    },
    ghostHighlight: {
        backgroundColor: 'transparent',
        borderColor: '#108ee999',
    },
    warningHighlight: {
        backgroundColor: '#d24747',
        borderColor: '#e94f4f',
    },
    wrapperStyle: {
        alignItems: 'center',
        justifyContent: 'center',
        borderRadius: 5,
        borderWidth: 1,
    },
    largeRaw: {
        height: 45,
        paddingLeft: 15,
        paddingRight: 15,
    },
    smallRaw: {
        height: 22,
        paddingLeft: 5,
        paddingRight: 5,
    },
    defaultRaw: {
        backgroundColor: '#ffffff',
        borderColor: '#dddddd',
    },
    primaryRaw: {
        backgroundColor: '#108ee9',
        borderColor: '#108ee9',
    },
    ghostRaw: {
        backgroundColor: 'transparent',
        borderColor: '#108ee9',
    },
    warningRaw: {
        backgroundColor: '#e94f4f',
        borderColor: '#e94f4f',
    },
    defaultDisabledRaw: {
        backgroundColor: '#dddddd',
        borderColor: '#dddddd',
    },
    primaryDisabledRaw: {
        opacity: 0.4,
    },
    ghostDisabledRaw: {
        borderColor: '#0000001A', // alpha 10%  
    },
    warningDisabledRaw: {
        opacity: 0.4,
    },
    defaultHighlightText: {
        color: '#000000',
    },
    primaryHighlightText: {
        color: '#ffffff4D', // alpha 30%
    },
    ghostHighlightText: {
        color: '#108ee999',
    },
    warningHighlightText: {
        color: '#ffffff4D', // alpha 30% 
    },
    largeRawText: {
        fontSize: 18,
    },
    smallRawText: {
        fontSize: 12,
    },
    defaultRawText: {
        color: '#000000',
    },
    primaryRawText: {
        color: '#ffffff',
    },
    ghostRawText: {
        color: '#108ee9',
    },
    warningRawText: {
        color: '#ffffff',
    },
    defaultDisabledRawText: {
        color: '#ffffff4D', // alpha 30% 
    },
    primaryDisabledRawText: {
        color: '#ffffff99', // alpha 60% 
    },
    ghostDisabledRawText: {
        color: '#0000001A', // alpha 10% 
    },
    warningDisabledRawText: {
        color: '#ffffff99', // alpha 60%  
    },
    indicator: {
        marginRight:8,
    },
});