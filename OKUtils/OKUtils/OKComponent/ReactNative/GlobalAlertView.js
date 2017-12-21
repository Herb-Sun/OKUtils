/**
 * 兼容iOS和Android的AlertView
 * Author sunhuabei
 * @providesModule GlobalAlertView

 * 使用案例1:(父组件通过props方式赋值)
<GlobalAlertView 
    visible={this.state.visible} //显示/隐藏 悉听君便
    title='这是title信息(选填)'
    titleStyle={这是title的style对象(选填,有默认样式)}
    message='这是message信息, (选填)'
    messageStyle={这是message的style对象(选填,有默认样式)}
    // 注意按钮要传数组, 对象的key要一致哟
    buttons={[
        {text:'知道了', style: 'Highlight', onPress: () => console.log('点击知道了') },
        {text:'哈哈', style: 'Normal',  onPress: () => console.log('点击哈哈')},
        {text:'cancel', style: 'Destructive',  onPress: () => console.log('点击cancel')}
    ]}
/>
 * 使用案例2: (alert组件内部控制)
<GlobalAlertView ref={ _alert => this._alertView = _alert}/>

this._alertView.updateState({
    visible={this.state.visible} //显示/隐藏 悉听君便
    title='这是title信息(选填)'
    titleStyle={这是title的style对象(选填,有默认样式)}
    message='这是message信息, (选填)'
    messageStyle={这是message的style对象(选填,有默认样式)}
    // 注意按钮要传数组, 对象的key要一致哟
    buttons={[
        {text:'知道了', style: 'Highlight', onPress: () => console.log('点击知道了') },
        {text:'哈哈', style: 'Normal',  onPress: () => console.log('点击哈哈')},
        {text:'cancel', style: 'Destructive',  onPress: () => console.log('点击cancel')}
    ]}
})
 */

import React, {PropTypes} from "react";
const {
    Component,
    View,
    Text,
    TextInput,
    StyleSheet,
    Modal,
    TouchableWithoutFeedback
} = TNBase;
import * as _ from 'lodash';

const INITIALIZED={
    visible: false,
    title: '',
    message: '',
    buttons: [],
    titleStyle: {},
    messageStyle: {},
}

export default class GlobalAlertView extends Component {

    static propTypes = {

        visible: PropTypes.bool,
        title: PropTypes.string,
        message: PropTypes.string,
        buttons: PropTypes.array,

        titleStyle: PropTypes.object,
        messageStyle: PropTypes.object,
    }

    static defaultProps = {
        ...INITIALIZED
    }

    constructor(props) {
        super(props);

        this.state={
            ...props,
            messageHeight: 0,
        }
    }

    shouldComponentUpdate(nextProps, nextState) {
        return !_.isEqual(nextProps, this.props) || !_.isEqual(nextState, this.state);
    }

    componentWillReceiveProps(nextProps) {
        this.setState({
            ...INITIALIZED,
            ...nextProps
        })
    }
    
    render() {

        const titleView = this._renderTitleView();
        const messageView = this._renderMessageView();
        const buttonView = this._renderButtonsView();

        return (
            <Modal
                animationType='fade'
                transparent={true}
                visible={this.state.visible}
                onRequestClose={ ()=> {} }>

                <View style={styles.containerStyle}>
                    <View style={styles.contentStyle}>
                        {titleView}
                        {messageView}
                        {buttonView}
                    </View>
                </View>
            </Modal>
        )
    }

    // 布局标题视图
    _renderTitleView = () => {
        if (this.state.title.length == 0) return <View/>;
        const titleStyle = this.state.titleStyle ? this.state.titleStyle : styles.titleStyle;
        const otherStyle = this.state.message.length == 0 ? {paddingBottom: 25} : {};
        return (
            <View style={[styles.titleViewStyle, otherStyle]}>
                <Text style={titleStyle}>{this.state.title}</Text>
            </View>
        );
    }

    // 布局信息视图
    _renderMessageView = () => {
        if (this.state.message.length == 0) return <View/>;
        const messageStyle = this.state.messageStyle ? this.state.messageStyle : styles.messageStyle;
        return (
            <View style={styles.messageViewStyle}>
                <TextInput
                    multiline={true}
                    editable={false}
                    underlineColorAndroid={'transparent'}
                    onContentSizeChange={this._onContentSizeChange}
                    defaultValue={this.state.message}
                    style={[messageStyle,{height:Math.min(300,this.state.messageHeight)}]}
                />
            </View>
        );
    }

    _onContentSizeChange = event => {
        const {contentSize={}} = event.nativeEvent;
        const {height} = contentSize;
        this.setState({
            messageHeight: height
        });
    }

    // 布局按钮视图
    _renderButtonsView = () => {

        if (this.state.buttons.length == 0) return <View/>;

        const buttonViews = [];
        const count = Math.max(this.state.buttons.length, 1); 
        const buttonWidth = `${1 / count * 100}%`;

        this.state.buttons.forEach((value, idx) => {

            const { text='', style='Default'} = value;
            const buttonBorderStyle = idx > 0 ? styles.buttonBorderStyle : {};
            
            let buttonTextStyle;
            switch (style) {
                case 'Default':
                case 'Normal':
                    buttonTextStyle = {fontSize: 18,color: '#666666',textAlign: 'center'}
                    break;
                case 'Highlight':
                    buttonTextStyle = {fontSize: 18,color: '#2dbb55',textAlign: 'center'}
                    break
                case 'Destructive':
                    buttonTextStyle = {fontSize: 18,color: '#ff7733',textAlign: 'center'}
                    break
                default:
                    buttonTextStyle = {fontSize: 18,color: '#666666',textAlign: 'center'}
                    break;
            }

            buttonViews.push(
                <TouchableWithoutFeedback
                    key={idx}
                    onPress={ () =>  {
                        this.setState({
                            visible: false
                        });
                        if (value.onPress) {
                            value.onPress();
                        }
                    } }>

                    <View style={[styles.buttonViewStyle, buttonBorderStyle, {width : buttonWidth}]}>
                        <Text style={buttonTextStyle}>{text}</Text>
                    </View>
                </TouchableWithoutFeedback>
            );
        })

        return (
            <View style={styles.buttonContainerStyle}>
                {buttonViews}
            </View>
        );
    }

    // PUBLIC method
    updateState(state={}) {
        this.setState({
            ...state
        })
    }
}

const styles = StyleSheet.create({

    containerStyle: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'rgba(0,0,0,0.5)',
        padding: 24,
    },

    contentStyle: {
        backgroundColor: '#ffffff',
        borderRadius: 6,
    },

    titleViewStyle: {
        justifyContent: 'center',
        alignItems: 'center',
        paddingTop: 25,
    },

    titleStyle: {
        fontSize: 18,
        fontWeight: 'bold',
        color: '#051b28',
    },

    messageViewStyle: {
        justifyContent: 'center',
        alignItems: 'center',
        paddingLeft: 20,
        paddingRight: 20,
        paddingTop: 18,
        paddingBottom: 20,
        borderBottomWidth: 1,
        borderBottomColor: 'rgba(0, 0, 0, 0.1)',
    },

    messageStyle: {
        fontSize: 13,
        lineHeight: 18,
        color: '#666666',
    },

    buttonContainerStyle: {
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        borderRadius: 4,
    },

    buttonViewStyle: {
        justifyContent: 'center',
        alignItems: 'center',
        height: 44,
    },

    buttonBorderStyle: {
        borderLeftWidth: 1,
        borderLeftColor: 'rgba(0, 0, 0, 0.1)',
    },
});